import tkinter
from objects import *
from time import sleep

tk = tkinter.Tk()
can = tkinter.Canvas(tk, bg="white", bd=1, width=wi, height=hi, cursor="plus")
rbt = Robot(can, 40, 40, 40, 40)
can.pack()
can.bind("<Button-1>", rbt.btn_one)
can.bind("<Button-3>", rbt.btn_three)

while(True):
    tk.update_idletasks()
    tk.update()
