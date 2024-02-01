import numpy as np
from matplotlib import pyplot as plt

class BiTreePlotter():
    def __init__(self, tree):
        self._tree = tree

    def plot(self, dx=-0.025, dy=0.4, size=12, digits=2, title='', shade_step=None, **kwargs):
        depth = self._tree.shape[1] - 1
        
        fig = plt.figure(figsize=(12,4), **kwargs)
        
        for i in range(depth):
            x = [1, 0, 1]
            for j in range(i):
                x.append(0)
                x.append(1)
            x = np.array(x) + i
            y = np.arange(-(i + 1), i + 2)[::-1]
            plt.plot(x, y, "bo-")

            pts = list(zip(x, y))

            for p in pts:
                value = round(self._tree[self._convert_to_index(p)][p[0]], digits)
                # plt.annotate(value, xy=p, xytext=(p[0] + dx, p[1] + dy), fontsize=size)
                plt.annotate(f'{value:.2f}', 
                                xy=p, 
                              xytext=(p[0] + 0.1, p[1] + 0), ha='left', va='center',
                              fontsize=size,
                              bbox=dict(boxstyle='round, pad=0.2', 
                              edgecolor='black', facecolor='wheat', alpha=0.95))
        if shade_step:
            s = np.arange(0,depth+1, 0.01)
            where = (s <= shade_step + 0.1) & (s > shade_step - 0.1)
            plt.fill_between(s, -(shade_step+0.5), (shade_step+0.5), where=where, alpha=0.5)

        plt.xlabel("n", fontsize=size)
        plt.xlim((-0.5, depth+0.5))
        # plt.ylabel("Option Value", fontsize=size)
        plt.title(title)
        plt.grid()
        
        return fig

    def _convert_to_index(self, p):
        # converts tree y values into indices for the tree matrix
        step = -2
        max = p[0]
        if max > 0:
            a = np.arange(max, -max + step, step)
            return int(np.where(a == p[1])[0])
        else:
            return 0