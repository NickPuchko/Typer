# Добавляем модули для работы с сетью
# Модули для обработки двумерных массивов
import numpy
import matplotlib.pyplot
# Функция сглаживания (Сигмоида)
import scipy.special
# Модуль для обрабокти изображения
import imageio
# Формирование нескольких файлов
import glob
import os
# from opencv2 import opencv

# letters = "АБВГДЕЗИКЛМНОПРСТУФХЦЧШЩЪЬЭЮЯ"
# letters = "Oswald", "Oswald", "Ubuntu", "Ubuntu", "Roboto", "Roboto", "Montserrat", "Montserrat", "Nunito", "Nunito", "Open Sans", "Open Sans", "Lobster", "Lobster", "Pacifico", "Pacifico"
# letters = " ", "rus", "eng"


c = os.listdir('display_lat')
letters = c



def print_letter(result):
    return letters[result]


class neuralNetwork:

    # Функция инициализации сети, где inputnodes - входной узел, outuptnodes -
    # выходной, hiddennodes - скрытый, lerningrate - скорость обучения
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

    # Функция тренировки сети
    def train(self, inputs_list, targets_list):
        # Преобразовать входной список в думерный массив
        inputs = numpy.array(inputs_list, ndmin=2).T
        targets = numpy.array(targets_list, ndmin=2).T

        # рассчитывать сигналы в скрытый слой
        hidden_inputs = numpy.dot(self.wih, inputs)
        # рассчитать сигналы, выходящие из скрытого слоя
        hidden_outputs = self.activation_function(hidden_inputs)

        # вычислить сигналы в финальный выходной слой
        final_inputs = numpy.dot(self.who, hidden_outputs)
        # рассчитать сигналы, выходящие из финального выходного слоя
        final_outputs = self.activation_function(final_inputs)

        # ошибка выходного слоя
        output_errors = targets - final_outputs
        # ошибка скрытого слоя - output_errors, разделенная по весам
        hidden_errors = numpy.dot(self.who.T, output_errors)

        # обновить веса для связей между скрытым и выходным слоями
        self.who += self.lr * numpy.dot((output_errors * final_outputs * (1.0 - final_outputs)),
                                        numpy.transpose(hidden_outputs))

        # обновить веса для связей между входным и скрытым слоями
        self.wih += self.lr * numpy.dot((hidden_errors * hidden_outputs * (1.0 - hidden_outputs)),
                                        numpy.transpose(inputs))

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

    def save(self):
        numpy.save('display_lat_saved_wih.npy', self.wih)
        numpy.save('display_lat_saved_who.npy', self.who)
        pass

    def load(self):
        self.wih = numpy.load('display_lat_saved_wih.npy')
        self.who = numpy.load('display_lat_saved_who.npy')
        return self.who


# Задать количество узлов


input_nodes = 784
hidden_nodes = 500
output_nodes = 57

# скорость обучения
learning_rate = 0.1

# создать экземпляр нейронной сети
n = neuralNetwork(input_nodes, hidden_nodes, output_nodes, learning_rate)

training_data_file = open("430_fonts/display_lat.csv", 'r')
training_data_list = training_data_file.readlines()
training_data_file.close()
# dan = []
epochs = 10
for e in range(epochs):
    print(e)
    g = 0
    # просмотреть все записи в наборе обучающих данных
    for record in training_data_list:
        # разделить запись запятыми ','
        all_values = record.split(',')
        if (all_values[0] != "\ufeff50"):
            inputs = (numpy.asfarray(all_values[1:]) / 255.0 * 0.99) + 0.01
            # создать целевые выходные значения (все 0,01, кроме желаемой метки, которая равна 0,99)
            targets = numpy.zeros(output_nodes) + 0.01
            # all_values[0] - целевая метка для этой запис
            targets[int(all_values[0])] = 0.99
            n.train(inputs, targets)
            n.save()
pass
pass

print("The end")

# test the neural network with our own images

# load image data from png files into an array

# def neural():
#     # eng = 0
#     # rus = 0
#     kol = 1
#     b = []
#     for i in range(kol):
#         c = str(i + 1)
#         img_array = imageio.imread('kik' + c + '.png', as_gray=True)
#         # reshape from 28x28 to list of 784 values, invert values
#         img_data = 255.0 - img_array.reshape(784)
#         # query the network
#         n.load()
#         outputs = n.query(img_data)
#         # print(outputs)
#
#         # the index of the highest value corresponds to the label
#         label = numpy.argmax(outputs)
#         answer = letters[label]
#         b.append(answer)
#
#     b_set = set(b)
#     most_common = 0
#     qty_most_common = 0
#
#     for item in b_set:
#         qty = b.count(item)
#         if qty > qty_most_common:
#             qty_most_common = qty
#             most_common = item
#
#     

# rt = neural()
