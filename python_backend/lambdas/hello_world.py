def lambda_handler(event, context):
    addition = 5 + 3
    return {
        'message': f'hello world!, {addition}'
    }