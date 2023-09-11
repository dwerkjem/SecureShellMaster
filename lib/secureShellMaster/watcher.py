from notifier import Push
import argparse
import sys
import os

argparser = argparse.ArgumentParser(description='Send a test push notification to your Pushbullet devices.')
argparser.add_argument('-t', '--title', type=str, help='Title of the push notification. If not specified, the default title will be used.')
argparser.add_argument('-b', '--body', type=str, help='Body of the push notification. If not specified, the default body will be used.')
argparser.add_argument('-T', '--test', action='store_true', default=False, help='Send a test push notification to your default device.')
args = argparser.parse_args()

title = args.title or "Test Push"
body = args.body or "This is a test push notification."
test = args.test or False

push = Push()
def test():
    
    devices = push.get_devices()
    devicesList = []
    for device in devices['devices']:
        nickname = device.get('nickname', "N/A")
        model = device.get('model', "N/A")
        manufacturer = device.get('manufacturer', "N/A")
        if not (nickname == "N/A" and model == "N/A" and manufacturer == "N/A"):
            devicesList.append(device)
    devicesStr = ""
    for i in range(len(devicesList)):
        devicesStr += str(i) + ": " + devicesList[i]['nickname'] + "\n"
    
    default_device = push.get_default_device()
    
    if not default_device:
        print("Default device ID is not set. Exiting.")
        return
    name = push.get_user()['name']
    
    response = push.send_push(f"Hello {name}", devicesStr, default_device)
    
    if 'active' in response and response['active']:
        print("Test push sent successfully.")
    else:
        print("Failed to send test push.")

def main(title, body):
    default_device = push.get_default_device()    
    response = push.send_push(title, body, default_device)

    if 'active' in response and response['active']:
        print("Push sent successfully.")
    else:
        print("Failed to send push.")

if test == True:
    test()
else:
    main(title, body)