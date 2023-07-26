import wget
import zipfile
import os

def add_folder_to_zip(zipf, folder_path, base_path=""):
    for root, _, files in os.walk(folder_path):
        for file in files:
            file_path = os.path.join(root, file)
            relative_path = os.path.relpath(file_path, folder_path)
            zipf.write(file_path, arcname=os.path.join(base_path, relative_path))

files_to_zip = [
    ('../src/', 'src'),
    ('../libs/', 'libs'),
    ('../textures/', 'textures'),
    ('../main.lua', 'main.lua'),
    ('../conf.lua', 'conf.lua'),
    ('../LICENSE', 'LICENSE')
]


# I DO NOT CLAIM ANY OWNERSHIP ON HUMP
# ALL CREDIT GOES TO THE ORIGINAL CREATORS
# HUMP: https://github.com/vrld/hump

if not os.path.exists("../libs/"):
    os.makedirs("../libs/")
    wget.download("https://raw.githubusercontent.com/vrld/hump/master/camera.lua", "../libs")
elif not os.path.exists("../libs/camera.lua"):
    wget.download("https://raw.githubusercontent.com/vrld/hump/master/camera.lua", "../libs")

with zipfile.ZipFile("../64game.love", 'w') as zipf:
    for file_path, arcname in files_to_zip:
        if file_path.endswith('/'):
            add_folder_to_zip(zipf, file_path, arcname)
        else:
            zipf.write(file_path, arcname=arcname)