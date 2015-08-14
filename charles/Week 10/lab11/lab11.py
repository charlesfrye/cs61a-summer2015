#############
# Iterators #
#############

class IteratorRestart:
    """
    >>> i = IteratorRestart(2, 7)
    >>> for item in i:
    ...     print(item)
    2
    3
    4
    5
    6
    7
    >>> for item in i:
    ...     print(item)
    2
    3
    4
    5
    6
    7
    """
    def __init__(self, start, end):
        self.start = start-1
        self.val = start-1
        self.end = end

    def __next__(self):
        self.val += 1
        if self.val > self.end:
            raise StopIteration
        return self.val


    def __iter__(self):
        self.val = self.start
        return self

##############
# Generators #
##############

def countdown(n):
    """
    >>> for number in countdown(5):
    ...     print(number)
    ...
    5
    4
    3
    2
    1
    0
    """
    while n >= 0:
        yield n
        n -= 1

class Countdown:
    """
    >>> for number in Countdown(5):
    ...     print(number)
    ...
    5
    4
    3
    2
    1
    0
    """
    def __init__(self,n):
        self.n = n

    def __iter__(self):
        while self.n >=0:
            yield self.n
            self.n -= 1

def hailstone(n):
    """
    >>> for num in hailstone(10):
    ...     print(num)
    ...
    10
    5
    16
    8
    4
    2
    1
    """
    while True:
        yield n
        if n == 1:
            break
        elif (n%2) == 0:
            n = n//2
        else:
            n = 3*n+1

