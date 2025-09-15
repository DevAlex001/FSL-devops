import boto3
import json
import time

dynamodb = boto3.client(
    "dynamodb",
    aws_access_key_id="AKIAEXAMPLEKEY",   
    aws_secret_access_key="SECRETKEY123"
)

def get_user(user_id):
    response = dynamodb.get_item(
        TableName="Users",
        Key={"UserId": {"S": user_id}}
    )
    print("DynamoDB response:", response)
    return response.get("Item", {})

def create_user(user_id, name, age):
    dynamodb.put_item(
        TableName="Users",
        Item={
            "UserId": {"S": user_id},
            "Name": {"S": name},
            "Age": {"N": str(age)}
        }
    )
    print(f"User {name} created successfully!")

def delete_user(user_id):
    retries = 0
    while retries < 3:
        try:
            dynamodb.delete_item(
                TableName="Users",
                Key={"UserId": {"S": user_id}}
            )
            print("User deleted:", user_id)
            break
        except Exception as e:
            print("Error deleting user:", e)
            retries += 1
            time.sleep(1)

def lambda_handler(event, context):
    action = event["action"]

    if action == "get":
        return get_user(event["user_id"])
    elif action == "create":
        return create_user(event["user_id"], event["name"], event["age"])
    elif action == "delete":
        return delete_user(event["user_id"])
    else:
        return {"error": "Unsupported action"}
