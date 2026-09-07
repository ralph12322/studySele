from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException, NoSuchElementException
from driver_manager import get_driver
import time
import os


class BasePage:
    DEFAULT_TIMEOUT = 10

    def __init__(self, driver=None):
        self.driver = driver or get_driver()

    # ---------- waiting helpers ----------

    def wait_for_visible(self, locator, timeout=DEFAULT_TIMEOUT):
        """Wait until an element is present AND visible. Returns the WebElement."""
        try:
            return WebDriverWait(self.driver, timeout).until(
                EC.visibility_of_element_located(locator)
            )
        except TimeoutException as exc:
            raise TimeoutException(
                f"Element {locator} was not visible after {timeout}s"
            ) from exc

    def wait_for_clickable(self, locator, timeout=DEFAULT_TIMEOUT):
        try:
            return WebDriverWait(self.driver, timeout).until(
                EC.element_to_be_clickable(locator)
            )
        except TimeoutException as exc:
            raise TimeoutException(
                f"Element {locator} was not clickable after {timeout}s"
            ) from exc

    def wait_for_all(self, locator, timeout=DEFAULT_TIMEOUT):
        """Wait for at least one matching element and return the full list."""
        try:
            return WebDriverWait(self.driver, timeout).until(
                EC.presence_of_all_elements_located(locator)
            )
        except TimeoutException:
            return []

    def wait_for_selector(self, locator, timeout=DEFAULT_TIMEOUT):
        try:
            return WebDriverWait(self.driver, timeout).until(
                EC.presence_of_element_located(locator)
            )
        except TimeoutError:
            return

    def is_element_present(self, locator, timeout=3):
        """Non-throwing existence check -- useful for negative/edge-case tests."""
        try:
            WebDriverWait(self.driver, timeout).until(
                EC.presence_of_element_located(locator)
            )
            return True
        except TimeoutException:
            return False

    def wait_for_visible_among(self, locator, timeout=DEFAULT_TIMEOUT):
        """When multiple elements share a locator, wait for and return the one currently visible."""
        end_time = time.time() + timeout
        while time.time() < end_time:
            elements = self.driver.find_elements(*locator)
            visible = [e for e in elements if e.is_displayed()]
            if visible:
                return visible[0]
            time.sleep(0.2)
        raise TimeoutException(f"No visible element found for {locator} after {timeout}s")

    def wait_for_link(self, locator, timeout=DEFAULT_TIMEOUT):
        """Wait for a specific link to be visible"""
        try:
            return WebDriverWait(self.driver, timeout).until(
                EC.element_to_be_clickable(locator)
            )
        except TimeoutException:
            raise TimeoutException(f"Link with locator '{locator}' was not clickable within {timeout}s")

    def wait_for_new_tab(self, tab):
        """Wait for a new browser tab to open. Returns True if it opened, False if it timed out."""
        try:
            WebDriverWait(self.driver, timeout=self.DEFAULT_TIMEOUT).until(
                EC.number_of_windows_to_be(len(tab) + 1)
            )
            return True
        except TimeoutException:
            return False

    def wait_until_url_contains(self, text):
        """Wait until the URL contains the given text; fails with a clear message if not."""
        try:
            WebDriverWait(self.driver, timeout=self.DEFAULT_TIMEOUT).until(
                EC.url_contains(text)
            )
        except TimeoutException:
            raise TimeoutException(
                f"URL did not contain '{text}' within {self.DEFAULT_TIMEOUT}s. "
                f"Current URL: {self.driver.current_url}"
            )
    # ---------- interaction helpers ----------

    def safe_click(self, locator, timeout=DEFAULT_TIMEOUT):
        element = self.wait_for_clickable(locator, timeout)
        element.click()
        return self

    def safe_type(self, locator, text, clear_first=True, timeout=DEFAULT_TIMEOUT):
        element = self.wait_for_visible(locator, timeout)
        if clear_first:
            element.clear()
        element.send_keys(text)
        return self

    def get_text(self, locator, timeout=DEFAULT_TIMEOUT):
        return self.wait_for_visible(locator, timeout).text

    # ---------- diagnostics ----------a

    def current_url(self):
        return self.driver.current_url