import cv2
import numpy as np
import numpy
import scipy.special
import imageio
import os
import shutil
import pytesseract
from PIL import Image

def detFonts(name):
    def findC():
        pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
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
                #cv2.rectangle(img, (x, y), (w + x, h + y), (0, 0, 255), 1)
                cv2.putText(img, el[11], (x, y), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255), 1)


                if ((len(el[11]) >= 4) and w > maxW):
                    maxW = w
                    crop_img = img[y:y + h + 10, x:x + w + 10]

                    # cv2.imwrite("img_res/whyres.png", crop_img)
                    # cv2.imshow("cropped", crop_img)
                    # cv2.waitKey(0)
                    m = el[11]
                    m = m.upper()


            except IndexError:
                pass



        image = crop_img
        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        se = cv2.getStructuringElement(cv2.MORPH_RECT, (8, 8))
        bg = cv2.morphologyEx(image, cv2.MORPH_DILATE, se)
        out_gray = cv2.divide(image, bg, scale=255)
        out_binary = cv2.threshold(out_gray, 127, 255, cv2.THRESH_OTSU)[1]
        # cv2.imwrite('resultat44.png', out_binary)
        # cv2.waitKey(0)



        imgFrame = Image.open(r'D:\Python_prog\api_for_font\ml_with_django\api_ml\ml\ml_module\frame.png')
        # textCv = cv2.imread('img_res/resultat.png')
        height, width = out_binary.shape[:2]
        cv2.imwrite('resultat.png', out_binary)
        out_binary = Image.open('resultat.png')
        frameResize = imgFrame.resize((width * 2, height * 2), Image.ANTIALIAS)
        hh = height // 2
        frameResize.paste(out_binary, (width // 2, height // 2))
        frameResize.save(name)
        print("findc")




    def opencv():
        for root, dirs, files in os.walk('result'):
            for f in files:
                os.unlink(os.path.join(root, f))
            for d in dirs:
                shutil.rmtree(os.path.join(root, d))
        image_file = name
        img = cv2.imread(image_file)
        width, height = img.shape[:2]
        img = cv2.resize(img, (height * 10, width * 10))
        # cv2.waitKey(0)
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
            image = 'D:/Python_prog/api_for_font/ml_with_django/api_ml/ml/ml_module/result/' + c + '.png'
            cv2.imwrite(image, letters[i][2])
            # cv2.waitKey(0)
        print("opencv")
        return k


    # name = 'name.png'
    try:
        findC()
    except IndexError:
        pass
    opencv()

    letters = "", "display", "sans-serif", "serif", "monospace", "handwriting"


    class neuralNetwork:

        def __init__(self, inputnodes, hiddennodes, outputnodes, learningrate):
            # Установить количество узлов во всех слоях
            self.inodes = inputnodes
            self.hnodes = hiddennodes
            self.onodes = outputnodes

            # Установить веса, идущие от узла к узлу и наполнить их случайными числами с центром в "0"
            self.wih = numpy.random.normal(0.0, pow(self.inodes, -0.5), (self.hnodes, self.inodes))
            self.who = numpy.random.normal(0.0, pow(self.hnodes, -0.5), (self.onodes, self.hnodes))

            # Установить скорость обучения
            self.lr = learningrate

            # Дополнительная функция активации - сигмоида
            self.activation_function = lambda x: scipy.special.expit(x)

            pass

        # Опрос нейросети
        def query(self, inputs_list):
            # преобразовать список входов в двумерный массив
            inputs = numpy.array(inputs_list, ndmin=2).T

            # рассчитывать сигналы в скрытый слой
            hidden_inputs = numpy.dot(self.wih, inputs)
            # рассчитать сигналы, выходящие из скрытого слоя
            hidden_outputs = self.activation_function(hidden_inputs)

            # вычислить сигналы в финальный выходной слой
            final_inputs = numpy.dot(self.who, hidden_outputs)
            # рассчитать сигналы, выходящие из финального выходного слоя
            final_outputs = self.activation_function(final_inputs)

            return final_outputs

        def load(self):
            self.wih = numpy.load('D:/Python_prog/api_for_font/ml_with_django/api_ml/ml/ml_module/category_saved_wih.npy')
            self.who = numpy.load('D:/Python_prog/api_for_font/ml_with_django/api_ml/ml/ml_module/category_saved_who.npy')
            return self.who

    input_nodes = 784
    hidden_nodes = 500
    output_nodes = 30
    learning_rate = 0.2
    n = neuralNetwork(input_nodes, hidden_nodes, output_nodes, learning_rate)

    # c = os.listdir('display_lat')
    # letters = c

    def neural():
        # eng = 0
        # rus = 0
        kol = opencv()
        b = []
        for i in range(kol):
            c = str(i + 1)
            img_array = imageio.imread('D:/Python_prog/api_for_font/ml_with_django/api_ml/ml/ml_module/result/' + c + '.png', as_gray=True)
            # reshape from 28x28 to list of 784 values, invert values
            img_data = 255.0 - img_array.reshape(784)
            # query the network
            n.load()
            outputs = n.query(img_data)
            # print(outputs)

            # the index of the highest value corresponds to the label
            label = numpy.argmax(outputs)
            answer = letters[label-1]
            b.append(answer)

        b_set = set(b)
        font = 0
        qty_most_common = 0

        for item in b_set:
            if item != '':
                qty = b.count(item)
                if qty > qty_most_common:
                    qty_most_common = qty
                    font = item
        print("neural")
        # print(font)
        return font

    res = neural()
    return res

# name = 'name.png'
# answer = detFonts(name)
# if answer == 0:
#     print("Font wasn't detected")
# else:
#     print(answer)
