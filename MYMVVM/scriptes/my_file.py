import os

def writeStrToFile(string,file_path):
    if not os.path.exists(file_path):
        with open(file_path, 'w') as file:
            file.write(string)
    
