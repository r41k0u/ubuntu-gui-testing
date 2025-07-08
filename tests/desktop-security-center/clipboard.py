import tkinter as tk
from robot.api.deco import keyword, library

@library(scope="GLOBAL")
class Clipboard:
    """Library for clipboard operations using tkinter."""

    @keyword 
    def get(self):
        """Get the current clipboard content using tkinter."""
        root = tk.Tk()
        root.withdraw()
        clipboard_text = root.clipboard_get()
        root.destroy()
        return clipboard_text
