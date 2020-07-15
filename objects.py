hi = 330
wi = 750

def rect(x, y, w, h, canvas, fill="#000", outline="#000"):
    return canvas.create_rectangle(x, hi-y-h, x+w, hi-y, fill=fill, outline=outline)

class Robot:
    def __init__(self, canvas, sx, sy, w, h):
        self.path = []
        self.path_lines = []
        self.path.append([sx, sy])
        self.can = canvas
        self.x = sx
        self.y = sy
        self.w = w
        self.h = h
        self.body = rect(self.x - (self.w/2), self.y - (self.h/2), self.w, self.h, self.can, "#eb9771", "#000")

    def move(self, x, y):
        self.can.coords(self.body, x - (self.w/2), y + (self.h/2), x + (self.w/2), y - (self.h/2))
        self.x = x
        self.y = y
        self.path.append([x, hi-y])
        self.path_lines.append(self.can.create_line(
            self.path[len(self.path) - 2][0], (self.path[len(self.path) - 2][1] - hi) * -1,
            x, y,
            width=2
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

    def btn_three(self, event):
        self.remove()
