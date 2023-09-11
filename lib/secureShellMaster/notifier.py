import pycurl
import os
from io import BytesIO
import json
import configparser

current_file_path = os.path.abspath(__file__)

# Get the directory containing the current file
current_directory = os.path.dirname(current_file_path)
# Navigate up two directories to get to the root
root_directory = os.path.dirname(os.path.dirname(current_directory))


class Push:
    def __init__(self, HEADER=None, BODY=None):
        self.access_token = os.environ.get('PUSH_API_KEY')
        self.root_directory = root_directory
        self.config = configparser.ConfigParser()
        self.config.read(self.root_directory + '/config.ini')
    def restGET(self, endpoint):
        buffer = BytesIO()
        c = pycurl.Curl()
        c.setopt(c.URL, 'https://api.pushbullet.com/v2/' + endpoint)
        c.setopt(c.HTTPHEADER, ['Access-Token: ' + self.access_token])
        c.setopt(c.WRITEDATA, buffer)
        c.perform()
        http_status = c.getinfo(pycurl.HTTP_CODE)
        c.close()

        if http_status != 200:
            print(f"Failed to get data from {endpoint}. HTTP status: {http_status}")
            exit(1)

        body = buffer.getvalue()
        return json.loads(body.decode('iso-8859-1'))

    def get_default_device(self):
        return self.config.get('DEFAULT', 'device_id', fallback=None)

    def send_push(self, title, body, device_iden):
        buffer = BytesIO()
        c = pycurl.Curl()
        c.setopt(c.URL, 'https://api.pushbullet.com/v2/pushes')
        c.setopt(c.HTTPHEADER, ['Access-Token: ' + self.access_token, 'Content-Type: application/json'])
        post_data = json.dumps({"device_iden": device_iden, "body": body, "title": title, "type": "note"})
        c.setopt(c.POSTFIELDS, post_data)
        c.setopt(c.WRITEDATA, buffer)
        c.perform()
        http_status = c.getinfo(pycurl.HTTP_CODE)
        c.close()

        if http_status != 200:
            print(f"Failed to send push. HTTP status: {http_status}")
            exit(1)

        body = buffer.getvalue()
        return json.loads(body.decode('iso-8859-1'))

    def get_user(self):
        return self.restGET('users/me')

    def get_devices(self):
        return self.restGET('devices')
# Initialize Push class
def main():
    push = Push()
    devices = push.get_devices()
    devicesList = []
    for device in devices['devices']:
        nickname = device.get('nickname', "N/A")
        model = device.get('model', "N/A")
        manufacturer = device.get('manufacturer', "N/A")
        if not (nickname == "N/A" and model == "N/A" and manufacturer == "N/A"):
            devicesList.append(device)
    if len(devicesList) == 0:
        print("No devices found. Please add a device to your account.")
        exit(1)

    # Select device
    print("Select a device:")

    for i, device in enumerate(devicesList):
        print(f"{i}: {device['nickname']} ({device['manufacturer']} {device['model']})")

    deviceIndex = int(input("Enter the number of the device you want to use: "))

    if deviceIndex < 0 or deviceIndex >= len(devicesList):
        print("Invalid device index.")
        exit(1)

    device = devicesList[deviceIndex]
    device_id = device['iden']
    
    # save device id to config file
    config = configparser.ConfigParser()
    config.read(root_directory + '/config.ini')
    config['DEFAULT']['device_id'] = device_id
    with open(root_directory + '/config.ini', 'w') as configfile:
        config.write(configfile)

    print(root_directory)
if __name__ == '__main__':
    main()