import os
import shutil

source_dir = '/data/tot_yd_data/add-2/'
target_dir = '/data/mmpose/tests/yd_data_test/'


if __name__ == "__main__":    
    for foldername, subfolders, filenames in os.walk(source_dir):
        if 'images' in subfolders:
            images_dir = os.path.join(foldername, 'images')
            target_images_dir = os.path.join(target_dir, os.path.basename(foldername))
            os.makedirs(target_images_dir, exist_ok=True)
            files = [x for x in os.listdir(images_dir) if x.endswith('.jpg')]
            print(subfolders)
            sample_files = files[::3]
            for file in sample_files:
                source_file = os.path.join(images_dir, file)
                target_file = os.path.join(target_images_dir, file)
                shutil.copy(source_file, target_file)