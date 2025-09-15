import boto3

def list_buckets():
    s3 = boto3.client("s3")

    response = s3.list_buckets()
    print("Buckets:", response)

    return [bucket["Name"] for bucket in response["Buckets"]]

def upload_file(bucket, key, filename):
    f = open(filename, "rb")
    s3 = boto3.client("s3")
    s3.upload_fileobj(f, bucket, key)
    print("File uploaded:", filename)
