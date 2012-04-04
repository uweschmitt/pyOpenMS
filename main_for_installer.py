import site
import distutils.sysconfig

from Tkinter import *
import tkFileDialog

from optparse import OptionParser

import sys
import os
import zipfile
import fnmatch
import cStringIO

class App(object):

    def __init__(self, root, local_path, system_path):

        self.target = None

        fr = Frame(root)
        fr.pack()
        self.fr = fr


        self.local_path = local_path
        self.system_path = system_path

        def set_grid(widget, r, c, **kw):
            default = dict(padx = 5, pady = 5, row=r, column=c)
            default.update(kw)
            getattr(widget, "grid").__call__(**default)

        def build_button(r, c, text,  command, fr=fr, **kw):
            b = Button(fr, text=text, command=command, width=30, height=2)
            set_grid(b, r=r, c=c, sticky=E, **kw)
            return b

        def build_label(r, c, text, fr=fr, **kw):
            l = Label(fr, text=text, relief=SUNKEN)
            set_grid(l, r, c, sticky=W, **kw)

        row = 0
        row += 1
        build_button(row, 0, "global install to\n(if you have admin rights)",
                     self.install_global)
        build_label(row, 1, text=system_path)

        row += 1
        build_button(row, 0, "local install to\n(for personal purposes)",
                     self.install_local)
        build_label(row, 1, text=local_path)


        row += 1
        build_button(row, 0, "individual install to\n(if you know what you do)",
                     self.install_individual)
        self.path = Entry(fr, width=80)
        set_grid(self.path, row, 1, sticky=W)
        build_button(row, 2, "choose Destination",  self.file_dialog)

        row += 1
        build_button(row, 0, "Quit", fr.quit)

    def install_local(self):
        self.install_to(self.local_path)

    def install_global(self):
        self.install_to(self.system_path)

    def install_individual(self):
        self.install_to(self.path.get())

    def install_to(self, target):
        self.target = target
        self.fr.quit()
          

    def file_dialog(self):
        dirname=tkFileDialog.askdirectory()
        self.path.delete(0,END)
        self.path.insert(0, dirname)


"""

Meter shows a Progressbar, ORIGINAL CODE FROM:

Michael Lange <klappnase (at) freakmail (dot) de>
The Meter class provides a simple progress bar widget for Tkinter.

INITIALIZATION OPTIONS:
The widget accepts all options of a Tkinter.Frame plus the following:

    fillcolor -- the color that is used to indicate the progress of the
                 corresponding process; default is "orchid1".
    value -- a float value between 0.0 and 1.0 (corresponding to 0% - 100%)
             that represents the current status of the process; values higher
             than 1.0 (lower than 0.0) are automagically set to 1.0 (0.0); default is 0.0 .
    text -- the text that is displayed inside the widget; if set to None the widget
            displays its value as percentage; if you don't want any text, use text="";
            default is None.
    font -- the font to use for the widget's text; the default is system specific.
    textcolor -- the color to use for the widget's text; default is "black".

WIDGET METHODS:
All methods of a Tkinter.Frame can be used; additionally there are two widget specific methods:

    get() -- returns a tuple of the form (value, text)
    set(value, text) -- updates the widget's value and the displayed text;
                        if value is omitted it defaults to 0.0 , text defaults to None .
"""

import Tkinter

class Meter(Tkinter.Frame):
    def __init__(self, master, width=300, height=20, bg='white', fillcolor='orchid1',\
                 value=0.0, text=None, font=None, textcolor='black', *args, **kw):
        Tkinter.Frame.__init__(self, master, bg=bg, width=width, height=height, *args, **kw)
        self._value = value

        self._canv = Tkinter.Canvas(self, bg=self['bg'], width=self['width'], height=self['height'],\
                                    highlightthickness=0, relief='flat', bd=0)
        self._canv.pack(fill='both', expand=1)
        self._rect = self._canv.create_rectangle(0, 0, 0, self._canv.winfo_reqheight(), fill=fillcolor,\
                                                 width=0)
        self._text = self._canv.create_text(self._canv.winfo_reqwidth()/2, self._canv.winfo_reqheight()/2,\
                                            text='', fill=textcolor)
        if font:
            self._canv.itemconfigure(self._text, font=font)

        self.text = StringVar()
        self.message = Label(self, textvariable=self.text, width=int(width/6))
        self.message.pack()

        self.set(value, text)
        self.bind('<Configure>', self._update_coords)

    def _update_coords(self, event):
        '''Updates the position of the text and rectangle inside the canvas when the size of
        the widget gets changed.'''
        # ld_looks like we have to call update_idletasks() twice to make sure
        # to get the results we expect
        self._canv.update_idletasks()
        self._canv.coords(self._text, self._canv.winfo_width()/2, self._canv.winfo_height()/2)
        self._canv.coords(self._rect, 0, 0, self._canv.winfo_width()*self._value, self._canv.winfo_height())
        self._canv.update_idletasks()

    def get(self):
        return self._value, self._canv.itemcget(self._text, 'text')

    def set(self, value=0.0, text=None):
        #make the value failsafe:
        if value < 0.0:
            value = 0.0
        elif value > 1.0:
            value = 1.0
        self._value = value
        if text == None:
            #if no text is specified use the default percentage string:
            text = str(int(round(100 * value))) + ' %'
        self._canv.coords(self._rect, 0, 0, self._canv.winfo_width()*value, self._canv.winfo_height())
        self._canv.itemconfigure(self._text, text=text)
        self._canv.update_idletasks()

local_path = site.USER_SITE
system_path = distutils.sysconfig.get_python_lib()

def ask_for_target():
    root = Tk()
    app = App(root, local_path=local_path, system_path=system_path)
    root.mainloop()
    rv = app.target
    root.destroy()
    return rv

def from_command_line():
    parser = OptionParser()

    parser.add_option("-l", "--local", dest="local", 
                      action="store_true",
                      help="local install to "+local_path)

    parser.add_option("-g", "--global", dest="global_", 
                      action="store_true",
                      help="global install to "+system_path)

    (option, args) = parser.parse_args()

    if option.local is option.global_:
        return None
    if option.local:
        return local_path
    else:
        return system_path

def install_to(target):

    root = Tk(className="install")
    m = Meter(root, fillcolor="gray", relief="ridge", width=500, height=30)
    m.pack(fill="x")
    m.set(0.0, "start install ... ")

    myself = zipfile.ZipFile(os.path.abspath(sys.argv[0]) )
    for f in myself.filelist:
        if fnmatch.fnmatch(f.filename, "pyOpenMS*.zip"):
            bytes_ = myself.read(f)
            bdist_zip = zipfile.ZipFile(cStringIO.StringIO(bytes_))
            fi = -1
            # find common path prefix, depth is os dependant:
            for if_ in bdist_zip.filelist:
                fields = if_.filename.split("/")
                if "pyOpenMS" not in fields:
                    continue
                fidx = fields.index("pyOpenMS")
                if fi<0:
                    fi = fidx
                else:
                    assert fi==fidx, "file corrupt"
            for i, if_ in enumerate(bdist_zip.filelist):
                fields = if_.filename.split("/")
                path = os.path.join(*fields[fi:])
                full_target = os.path.join(target, path)
                    
                if not os.path.exists(os.path.dirname(full_target)): 
                    os.makedirs(os.path.dirname(full_target))
                bytes_ = bdist_zip.read(if_)
                m.text.set(path)
                open(full_target,"wb").write(bytes_)
                m.set(1.0 * i / len(bdist_zip.filelist))

    
target = from_command_line()
if target is None:
    target = ask_for_target()
if target is None:
    exit(1)


install_to(target)    


