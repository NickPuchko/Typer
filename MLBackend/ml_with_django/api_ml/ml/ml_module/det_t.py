import cv2
import pytesseract
from PIL import Image
from langdetect import detect


def findC(name):
    pytesseract.pytesseract.tesseract_cmd = 'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'
    img = cv2.imread(name)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    config = r'--oem 3 --psm 6'
    maxW = 0
    data = pytesseract.image_to_data(img, config=config)

    for i, el in enumerate(data.splitlines()):
        if i == 0:
            continue
        el = el.split()
        try:
            x, y, w, h = int(el[6]), int(el[7]), int(el[8]), int(el[9])
            cv2.rectangle(img, (x, y), (w + x, h + y), (0, 0, 255), 1)
            cv2.putText(img, el[11], (x, y), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255), 1)

            if ((len(el[11]) >= 4) and w > maxW):
                maxW = w
                crop_img = img[y:y + h + 10, x:x + w + 10]

                # cv2.imwrite("img_res/whyres.png", crop_img)
                # cv2.imshow("cropped", crop_img)
                # cv2.waitKey(0)
                m = el[11]
                m = m.upper()
                print(m)
                z = pytesseract.image_to_string(crop_img, lang='eng', config=config)
                print(detect(z))
                z = pytesseract.image_to_string(crop_img, lang='rus', config=config)
                z = z.upper()
                print(detect(z))
                print(z)

        except IndexError:
            pass
    # cv2.imshow("res", crop_img)
    # cv2.waitKey(0)



    image = crop_img
    image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    se = cv2.getStructuringElement(cv2.MORPH_RECT, (8, 8))
    bg = cv2.morphologyEx(image, cv2.MORPH_DILATE, se)
    out_gray = cv2.divide(image, bg, scale=255)
    out_binary = cv2.threshold(out_gray, 127, 255, cv2.THRESH_OTSU)[1]
    # cv2.imwrite('img_res/resultat.png', out_binary)
    # cv2.waitKey(0)



    imgFrame = Image.open('frame.png')
    # textCv = cv2.imread('img_res/resultat.png')
    height, width = out_binary.shape[:2]
    cv2.imwrite('img_res/resultat.png', out_binary)
    out_binary = Image.open('img_res/resultat.png')
    frameResize = imgFrame.resize((width * 2, height * 2), Image.ANTIALIAS)
    hh = height // 2
    frameResize.paste(out_binary, (width // 2, height // 2))
    frameResize.save("resultat.png")

