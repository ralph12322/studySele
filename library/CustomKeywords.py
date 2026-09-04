from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from driver_manager import get_driver
from pages.home_page import HomePage
from robot.api.deco import keyword
import time


class CustomKeywords:
    def __init__(self, driver=None):
        self._driver = driver  # don't create anything yet

    @property
    def driver(self):
        """Lazily fetch the shared driver only when actually needed."""
        if self._driver is None:
            self._driver = get_driver()
        return self._driver
    
    @keyword("Open Portfolio")
    def open_portfolio(self, url):
        """Navigates to the given URL using the shared driver."""
        self.driver.get(url)
        return self
    @keyword("Click Nav Buttons")
    def click_chat_bubble(self):
        """Perform Click and close to each one of the navigator buttons"""
        self.home_page = HomePage(self.driver)
        self.home_page.test_buttons()

    def wait_seconds(self, seconds):
        time.sleep(float(seconds))
        return self

    @keyword("Close Browser")
    def close_browser(self):
        self.driver.quit()
        return self