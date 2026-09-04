from selenium import webdriver

_driver = None  # module-level "singleton" slot


def get_driver():
    global _driver
    if _driver is None:
        _driver = webdriver.Chrome()
    return _driver


def quit_driver():
    global _driver
    if _driver is not None:
        _driver.quit()
        _driver = None