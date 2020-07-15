import math as m
hi = 668
wi = 1192

def rect(x, y, w, h, canvas, fill="#000", outline="#000"):
    return canvas.create_rectangle(x, hi-y-h, x+w, hi-y, fill=fill, outline=outline)

class Robot:
    def __init__(self, canvas, sx, sy, w, h, sang):
        self.path = []
        self.path_lines = []
        self.path.append([sx, sy])
        self.can = canvas
        self.x = sx
        self.y = sy
        self.w = w
        self.h = h
        self.sang = sang
        self.body = rect(self.x - (self.w/2), self.y - (self.h/2), self.w, self.h, self.can, "#eb9771", "#000")

    def move(self, x, y):
        self.can.coords(self.body, x - (self.w/2), y + (self.h/2), x + (self.w/2), y - (self.h/2))
        self.x = x
        self.y = y
        self.path.append([x, hi-y])
        self.path_lines.append(self.can.create_line(
            self.path[len(self.path) - 2][0], (self.path[len(self.path) - 2][1] - hi) * -1,
            x, y,
            width=6, fill="#622775"
        ))
        print(self.path)

    def remove(self):
        if(len(self.path) > 1):
            self.can.delete(self.path_lines.pop())
            if(len(self.path_lines) > 0):
                self.can.delete(self.path_lines.pop())
            self.path.pop()
            x, y = self.path.pop()
            self.move(x, (y-hi) * -1)
            print(self.path)

    def position(self):
        return (self.x, self.y)

    def btn_one(self, event):
        self.move(event.x, event.y)

    def btn_two(self, event):
        self.eval()

    def btn_three(self, event):
        self.remove()

    def eval(self):
        prog_str = ""
        angles = []
        for i in range(len(self.path)):
            if(i > 0):
                if(self.path[i][0] != self.path[i-1][0]):
                    angle = m.degrees(m.atan((self.path[i][1]- self.path[i-1][1])/(self.path[i][0]- self.path[i-1][0])))
                elif(self.path[i][1] > self.path[i-1][1]):
                    angle = 90
                else:
                    angle = -90
                angles.append(angle)
            else:
                pass

        print(angles)
