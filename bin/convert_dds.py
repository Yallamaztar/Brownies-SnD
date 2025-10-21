if __name__ == '__main__':
    import os
    imgs = os.path.join("images")
    for image in os.listdir(imgs):
        if image.endswith(".dds"):
            os.system(fr"ImageConverter.exe {os.path.join(imgs, image)}")