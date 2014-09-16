#!/usr/bin/python
# -*- coding: utf-8 -*-

"""

Playing around with `staticmethod` and `classmethod`.

luismartingil
www.luismartingil.com

"""


def loginout(fun):
    def my_wrapper(*args, **kwargs):
        times = 20
        print '%s %s' % ('>' * times, fun.__name__)
        fun(*args, **kwargs)
        print '%s %s' % ('<' * times, fun.__name__)
    return my_wrapper

def logtitle(fun):
    def my_wrapper(*args, **kwargs):
        print '=' * len(fun.__name__)
        print fun.__name__
        print '=' * len(fun.__name__)
        fun(*args, **kwargs)
        print '=' * len(fun.__name__)
        print '\n' * 2
    return my_wrapper


class MyClass(object):

    data = None

    @loginout
    def __init__(self):
        pass

    @staticmethod
    @loginout
    def smethod(*args):
        """ Static method's first argument is never the class.
        Static methods are used to implement functionalities
        related to the class that don't need the actual class
        or instance to do the work.
        """
        print 'args for @staticmethod: %s' % (str(args))

    @classmethod
    @loginout
    def cmethod(cls, *args):
        """ Wheter this method is called from the class
        MyClass.cmethod() or an instance of it obj.cmethod(),
        `cls` (first arg) will always be 'MyClass'
        """
        print 'cls for @classmethod: %s' % (cls)
        print 'args for @classmethod: %s' % (str(args))
        print 'issubclass(cls, MyClass): %s' % (issubclass(cls, MyClass))


class MyClassChild(MyClass):
    pass


class MyClassGrandChild(MyClassChild):
    pass


args = ['arg1', 'arg2', 'arg3']

@logtitle
def check_class_class():
    MyClass.smethod(*args)
    MyClass.cmethod(*args)

@logtitle
def check_class_instance():
    obj = MyClass()
    obj.smethod(*args)
    obj.cmethod(*args)

@logtitle
def check_subclass_class():
    MyClassChild.smethod(*args)
    MyClassChild.cmethod(*args)

@logtitle
def check_subclass_instance():
    obj = MyClassChild()
    obj.smethod(*args)
    obj.cmethod(*args)

@logtitle
def check_grandchildclass_class():
    MyClassGrandChild.smethod(*args)
    MyClassGrandChild.cmethod(*args)

@logtitle
def check_grandchildclass_instance():
    obj = MyClassGrandChild()
    obj.smethod(*args)
    obj.cmethod(*args)

# Test
check_class_class()
check_class_instance()

check_subclass_class()
check_subclass_instance()

check_grandchildclass_class()
check_grandchildclass_instance()


# Output

# =================
# check_class_class
# =================
# >>>>>>>>>>>>>>>>>>>> smethod
# args for @staticmethod: ('arg1', 'arg2', 'arg3')
# <<<<<<<<<<<<<<<<<<<< smethod
# >>>>>>>>>>>>>>>>>>>> cmethod
# cls for @classmethod: <class '__main__.MyClass'>
# args for @classmethod: ('arg1', 'arg2', 'arg3')
# issubclass(cls, MyClass): True
# <<<<<<<<<<<<<<<<<<<< cmethod
# =================



# ====================
# check_class_instance
# ====================
# >>>>>>>>>>>>>>>>>>>> __init__
# <<<<<<<<<<<<<<<<<<<< __init__
# >>>>>>>>>>>>>>>>>>>> smethod
# args for @staticmethod: ('arg1', 'arg2', 'arg3')
# <<<<<<<<<<<<<<<<<<<< smethod
# >>>>>>>>>>>>>>>>>>>> cmethod
# cls for @classmethod: <class '__main__.MyClass'>
# args for @classmethod: ('arg1', 'arg2', 'arg3')
# issubclass(cls, MyClass): True
# <<<<<<<<<<<<<<<<<<<< cmethod
# ====================



# ====================
# check_subclass_class
# ====================
# >>>>>>>>>>>>>>>>>>>> smethod
# args for @staticmethod: ('arg1', 'arg2', 'arg3')
# <<<<<<<<<<<<<<<<<<<< smethod
# >>>>>>>>>>>>>>>>>>>> cmethod
# cls for @classmethod: <class '__main__.MyClassChild'>
# args for @classmethod: ('arg1', 'arg2', 'arg3')
# issubclass(cls, MyClass): True
# <<<<<<<<<<<<<<<<<<<< cmethod
# ====================



# =======================
# check_subclass_instance
# =======================
# >>>>>>>>>>>>>>>>>>>> __init__
# <<<<<<<<<<<<<<<<<<<< __init__
# >>>>>>>>>>>>>>>>>>>> smethod
# args for @staticmethod: ('arg1', 'arg2', 'arg3')
# <<<<<<<<<<<<<<<<<<<< smethod
# >>>>>>>>>>>>>>>>>>>> cmethod
# cls for @classmethod: <class '__main__.MyClassChild'>
# args for @classmethod: ('arg1', 'arg2', 'arg3')
# issubclass(cls, MyClass): True
# <<<<<<<<<<<<<<<<<<<< cmethod
# =======================



# ===========================
# check_grandchildclass_class
# ===========================
# >>>>>>>>>>>>>>>>>>>> smethod
# args for @staticmethod: ('arg1', 'arg2', 'arg3')
# <<<<<<<<<<<<<<<<<<<< smethod
# >>>>>>>>>>>>>>>>>>>> cmethod
# cls for @classmethod: <class '__main__.MyClassGrandChild'>
# args for @classmethod: ('arg1', 'arg2', 'arg3')
# issubclass(cls, MyClass): True
# <<<<<<<<<<<<<<<<<<<< cmethod
# ===========================



# ==============================
# check_grandchildclass_instance
# ==============================
# >>>>>>>>>>>>>>>>>>>> __init__
# <<<<<<<<<<<<<<<<<<<< __init__
# >>>>>>>>>>>>>>>>>>>> smethod
# args for @staticmethod: ('arg1', 'arg2', 'arg3')
# <<<<<<<<<<<<<<<<<<<< smethod
# >>>>>>>>>>>>>>>>>>>> cmethod
# cls for @classmethod: <class '__main__.MyClassGrandChild'>
# args for @classmethod: ('arg1', 'arg2', 'arg3')
# issubclass(cls, MyClass): True
# <<<<<<<<<<<<<<<<<<<< cmethod
# ==============================
