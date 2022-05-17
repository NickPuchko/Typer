import cv2
import numpy as np
import shutil
import os

def opencv(name1):
    for root, dirs, files in os.walk('result1'):
        for f in files:
            os.unlink(os.path.join(root, f))
        for d in dirs:
            shutil.rmtree(os.path.join(root, d))
    image_file = name1
    img = cv2.imread(image_file)
    width, height = img.shape[:2]
    img = cv2.resize(img, (height*5, width*5))
    cv2.imwrite("sd.png", img)
    cv2.waitKey(0)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    ret, thresh = cv2.threshold(gray, 127, 255, 0)
    img_erode = cv2.erode(thresh, np.ones((3, 3), np.uint8), iterations=10)
    contours, hierarchy = cv2.findContours(img_erode, cv2.RETR_TREE, cv2.CHAIN_APPROX_NONE)
    output = img.copy()
    out_size = 28
    letters = []
    k = 0
    for i, contour in enumerate(contours):
        (x, y, w, h) = cv2.boundingRect(contour)
        if hierarchy[0][i][3] == 0:
            cv2.rectangle(output, (x, y), (x + w, y + h), (255, 0, 0), 1)
            letter = gray[y:y + h, x:x + w]
            size_max = max(w, h)
            letter_coun = 255 * np.ones(shape=[size_max, size_max], dtype=np.uint8)
            if w > h:
                k += 1
                y_pos = size_max // 2 - h // 2
                letter_coun[y_pos:y_pos + h, 0:w] = letter
            elif w < h:
                k += 1
                x_pos = size_max // 2 - w // 2
                letter_coun[0:h, x_pos:x_pos + w] = letter
            else:
                k += 1
                letter_coun = letter
            output_size = cv2.resize(letter_coun, (out_size, out_size), interpolation=cv2.INTER_AREA)
            letters.append((x, w, output_size))

            letters.sort(key=lambda x: x[0], reverse=False)

            for i in range(len(letters)):
                c = str(i + 1)
                image = 'result1/' + c + '.png'
                cv2.imwrite(image, letters[i][2])
                print("iio")
                cv2.waitKey(0)
    print("The end")
    return k

name1 = 'serif_lat\Alike.png'
opencv(name1)
