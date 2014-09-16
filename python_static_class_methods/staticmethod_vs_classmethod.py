#!/usr/bin/python
# -*- coding: utf-8 -*-

"""

Playing around with `staticmethod` and `classmethod`.

luismartingil
www.luismartingil.com

"""

def wrapper(fun):
    def my_wrapper(*args, **kwargs):
        times = 20
        print '%s %s' % ('>' * times, fun.__name__)
        fun(*args, **kwargs)
        print '%s %s' % ('<' * times, fun.__name__)
    return my_wrapper


class MyClass(object):

    data = None

    @wrapper
    def __init__(self):
        pass

    @staticmethod
    @wrapper
    def smethod(*args):
        """ Static method's first argument is never the class.
        Static methods are used to implement functionalities
        related to the class that don't need the actual class
        or instance to do the work.
        """
        print 'args for @staticmethod: %s' % (str(args))

    @classmethod
    @wrapper
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

def title(text):
    print '=' * len(text)
    print text
    print '=' * len(text)    

def title_end():
    print ''

def check_class_class():
    title('class_class')
    MyClass.smethod(*args)
    MyClass.cmethod(*args)
    title_end()

def check_class_instance():
    title('class_instance')
    obj = MyClass()
    obj.smethod(*args)
    obj.cmethod(*args)
    title_end()

def check_subclass_class():
    title('subclass_class')
    MyClassChild.smethod(*args)
    MyClassChild.cmethod(*args)
    title_end()

def check_subclass_instance():
    title('subclass_instance')
    obj = MyClassChild()
    obj.smethod(*args)
    obj.cmethod(*args)
    title_end()

def check_grandchildclass_class():
    title('grandchildclass_class')
    MyClassGrandChild.smethod(*args)
    MyClassGrandChild.cmethod(*args)
    title_end()

def check_grandchildclass_instance():
    title('grandchildclass_instance')
    obj = MyClassGrandChild()
    obj.smethod(*args)
    obj.cmethod(*args)
    title_end()

# Test
check_class_class()
check_class_instance()

check_subclass_class()
check_subclass_instance()

check_grandchildclass_class()
check_grandchildclass_instance()


# Output

# ===========
# class_class
# ===========
# >>>>>>>>>>>>>>>>>>>> smethod
# args for @staticmethod: ('arg1', 'arg2', 'arg3')
# <<<<<<<<<<<<<<<<<<<< smethod
# >>>>>>>>>>>>>>>>>>>> cmethod
# cls for @classmethod: <class '__main__.MyClass'>
# args for @classmethod: ('arg1', 'arg2', 'arg3')
# issubclass(cls, MyClass): True
# <<<<<<<<<<<<<<<<<<<< cmethod

# ==============
# class_instance
# ==============
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

# ==============
# subclass_class
# ==============
# >>>>>>>>>>>>>>>>>>>> smethod
# args for @staticmethod: ('arg1', 'arg2', 'arg3')
# <<<<<<<<<<<<<<<<<<<< smethod
# >>>>>>>>>>>>>>>>>>>> cmethod
# cls for @classmethod: <class '__main__.MyClassChild'>
# args for @classmethod: ('arg1', 'arg2', 'arg3')
# issubclass(cls, MyClass): True
# <<<<<<<<<<<<<<<<<<<< cmethod

# =================
# subclass_instance
# =================
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

# =====================
# grandchildclass_class
# =====================
# >>>>>>>>>>>>>>>>>>>> smethod
# args for @staticmethod: ('arg1', 'arg2', 'arg3')
# <<<<<<<<<<<<<<<<<<<< smethod
# >>>>>>>>>>>>>>>>>>>> cmethod
# cls for @classmethod: <class '__main__.MyClassGrandChild'>
# args for @classmethod: ('arg1', 'arg2', 'arg3')
# issubclass(cls, MyClass): True
# <<<<<<<<<<<<<<<<<<<< cmethod

# ========================
# grandchildclass_instance
# ========================
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
