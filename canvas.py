import tkinter
from objects import *
from time import sleep

tk = tkinter.Tk()
can = tkinter.Canvas(tk, bg="white", bd=1, width=wi, height=hi, cursor="plus")
map = tkinter.PhotoImage(file="city_shaper.png")
can.create_image(0, 0, image=map, anchor=tkinter.NW)
rbt = Robot(can, 50, 50, 50, 50, 0)
can.pack()
can.bind("<Button-1>", rbt.btn_one)
can.bind("<Button-2>", rbt.btn_two)
can.bind("<Button-3>", rbt.btn_three)

while(True):
    tk.update_idletasks()
    tk.update()
