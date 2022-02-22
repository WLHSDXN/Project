########################引用数据文件与函数########################
import pygame
pygame.init()
import io
import cv2
from PIL import Image, ImageDraw, ImageFont
from time import sleep
import os
import time
import numpy
########################定义变量########################
map_width = 1920
map_height = 1080
gameScreen = pygame.display.set_mode((map_width,map_height))#初始化一个屏幕
########################定义函数########################
#显示屏幕
def gameLoop(i = 0 ,image = "file\\images\s0.jpg",image2 = None):
    Jpg = readJpg()
    while True:
        # for i in range(len(Jpg)):
            image = "file\s"+str(i)+".jpg"
            #设置背景
            background = pygame.image.load(image)
            #居中显示图片
            pic = picSize(image)
            width = (map_width - pic[0] ) // 2
            height = (map_height - pic[1]) // 2
            gameScreen.blit(background,(width,height))#在屏幕上显示一个background
            if image2 != None:
                image2 = "file\\images\s"+str(i)+".jpg"
                background2 = pygame.image.load(image2)
                gameScreen.blit(background2,(310,760))#在屏幕上显示一个background
            #显示完图片之后更新屏幕
            pygame.display.update()
            #获取台词下一页（如果存在）
            text = readTextContent("file\\t"+str(i)+".txt")
            if len(text) > 4:
                pageA = text[4]
                pageB = text[5]
            #监听
            for event in pygame.event.get():
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_ESCAPE:
                        pygame.quit()
                        sys.exit()
                    if event.key == pygame.K_SPACE and len(text) < 5 and str(i+1) != "37" and str(i+1) != "38":#36是正常故事线的页数 #拦住最后两页
                        imageUrl = "file\s"+str(i+1)+".jpg"
                        imageUrl2 = "file\\images\s"+str(i+1)+".jpg"
                        gameLoop(int(i+1),imageUrl,imageUrl2)
                        pygame.display.update()
                    if  event.key == pygame.K_a and len(text) >= 5:
                        imageUrl = "file\s"+str(pageA)+".jpg"
                        imageUrl2 = "file\\images\s"+str(pageA)+".jpg"
                        gameLoop(int(pageA),imageUrl,imageUrl2)
                        pygame.display.update()
                    if event.key == pygame.K_b and len(text) >= 5:
                        imageUrl = "file\s"+str(pageB)+".jpg"
                        imageUrl2 = "file\\images\s"+str(pageB)+".jpg"
                        gameLoop(int(pageB),imageUrl,imageUrl2)
                        pygame.display.update()
#获取图片长宽
def picSize(bg_url):
    img1 = Image.open(bg_url)
    return img1.size  # w, h 返回序列
#生成台词图片
def cv2ImgAddText(img, text = ["默认"], left = 0, top = 0, textColor=(255, 0, 0), textSize=20):
    if (isinstance(img, numpy.ndarray)):  # 判断是否OpenCV图片类型
        img = Image.fromarray(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
    # 创建一个可以在给定图像上绘图的对象
    draw = ImageDraw.Draw(img)
    # 字体的格式
    fontStyle = ImageFont.truetype(
        "font/simfang.ttf", textSize, encoding="utf-8")
    # 绘制文本
    for i in range(len(text)):
        if i != 4 :#i == 4时，不是台词，是下一个页
            draw.text((left, top + i * 40), text[i], textColor, font=fontStyle)
            # print(len(text))
            # print(text) 
        # if i == 4:
        #     print(text[4])
    # 转换回OpenCV格式
    return cv2.cvtColor(numpy.asarray(img), cv2.COLOR_RGB2BGR)
def addText(jpgUrl = "file\s1.jpg",inText = ["默认"],outUrl = "file\\images\\new_s1.png",left = 0, top = 0, textColor=(0, 255, 0), textSize=20):
    img = cv2ImgAddText(cv2.imread(jpgUrl), inText, left, top, textColor, textSize)
    # cv2.imshow('show', img)#展示
    cv2.imwrite(outUrl, img)
#读入文件列表
def readFile():
    path = "./file/"
    files = []
    dirs = os.listdir(path)
    for diretion in dirs:
        files.append(diretion)
    return files#返回文件名列表
def readJpg():
    path = "./file/"
    JPG = []
    dirs = os.listdir(path)
    for diretion in dirs:
        if diretion.endswith(".jpg"):
            JPG.append(diretion)
    return JPG#返回文件名列表
#读入txt文件
def readTextContent(url = "file\\t8.txt"):
    with open(url , "r" , encoding='UTF-8') as f:
        text = []
        for line in f.readlines():
            text.append(line.strip('\n'))   #去掉列表中每一个元素的换行符
    return text#返回一个列表url = "file\\t" + str(i) + ".txt"
########################主程序########################
# #生成第一张图片
addText("file\\temp\s-1.jpg",["请按空格键继续"],"file\s0.jpg",650, 700, (0, 0 , 0), 30)
File = readFile()
Jpg = readJpg()
Text = readTextContent()
#生成剩下的台词图片
for i in range(1,len(Jpg)):
    # jpgUrl = "file\s"+str(i)+".jpg"
    textUrl = "file\\t"+str(i)+".txt"
    outUrl = "file\\images\s"+str(i)+".jpg"
    addText("file\\temp\\textbg.jpg",readTextContent(textUrl),outUrl,20, 20, (0, 0 , 0), 30)
#一直显示屏幕    
gameLoop()




