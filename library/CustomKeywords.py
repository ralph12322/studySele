from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from driver_manager import get_driver, quit_driver
from pages.home_page import HomePage
from robot.api.deco import keyword
import time


class CustomKeywords:

    def __init__(self):
        self._driver = None
        self._home_page = None

    @property
    def driver(self):
        """Lazily fetch the shared driver only when actually needed."""
        if self._driver is None:
            self._driver = get_driver()
        return self._driver

    @property
    def home_page(self):
        if self._home_page is None:
            self._home_page = HomePage(self.driver)
        return self._home_page
    
    @keyword("Open Portfolio")
    def open_portfolio(self, url):
        """Navigates to the given URL using the shared driver."""
        self.driver.get(url)
        return self
    @keyword("Click Nav Buttons")
    def click_chat_bubble(self):
        """Perform Click and close to each one of the navigator buttons"""
        self.home_page.test_navigation_buttons()

    def wait_seconds(self, seconds):
        time.sleep(float(seconds))
        return self

    @keyword("Switch To Light Mode")
    def switch_to_light_mode(self):
        """Toggles the site to light mode."""
        self.home_page.toggle_to_light_mode()

    @keyword("Switch To Dark Mode")
    def switch_to_dark_mode(self):
        """Toggles the site to dark mode."""
        self.home_page.toggle_to_dark_mode()

    @keyword("Opens the Resume")
    def open_resume(self):
        """Open the Resume then verify if it is actually opened"""
        self.home_page.open_resume()
        time.sleep(2)

    @keyword("Close Browser")
    def close_browser(self):
        """Close the driver browser"""
        quit_driver()
        return self