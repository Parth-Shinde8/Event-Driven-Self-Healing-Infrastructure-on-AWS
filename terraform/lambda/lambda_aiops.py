import boto3
import datetime
from datetime import timezone

REGION = "ap-south-1"
APP_INSTANCE_ID = "i-077c021c3eae8c71b"
SNS_TOPIC_ARN = "arn:aws:sns:ap-south-1:836479503728:aiops-alerts"

DEVICE = "xvda1"
PATH = "/"
FSTYPE = "ext4"

THRESHOLD = 20.0
WINDOW_MINUTES = 30

cloudwatch = boto3.client("cloudwatch", region_name=REGION)
ec2 = boto3.client("ec2", region_name=REGION)
sns = boto3.client("sns", region_name=REGION)

def fetch_disk_usage():
    end = datetime.datetime.now(timezone.utc)
    start = end - datetime.timedelta(minutes=WINDOW_MINUTES)

    response = cloudwatch.get_metric_statistics(
        Namespace="CWAgent",
        MetricName="disk_used_percent",
        Dimensions=[
            {"Name": "InstanceId", "Value": APP_INSTANCE_ID},
            {"Name": "device", "Value": DEVICE},
            {"Name": "path", "Value": PATH},
            {"Name": "fstype", "Value": FSTYPE},
        ],
        StartTime=start,
        EndTime=end,
        Period=300,
        Statistics=["Average"]
    )

    if not response["Datapoints"]:
        return 0.0

    return max(d["Average"] for d in response["Datapoints"])

def lambda_handler(event, context):
    disk = fetch_disk_usage()

    if disk > THRESHOLD:
        ec2.reboot_instances(InstanceIds=[APP_INSTANCE_ID])
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Subject="AIOps Alert: Disk Spike",
            Message=f"Disk usage {disk:.2f}% exceeded threshold"
        )

    return {"disk": disk}
