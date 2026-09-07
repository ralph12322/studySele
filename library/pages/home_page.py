from selenium.webdriver.common.by import By
from pages.base_page import BasePage
import time

class HomePage(BasePage):
    navButtons = (By.CLASS_NAME, "nav-pill-btn")
    closeButton = (By.CLASS_NAME, "close-btn")
    toggleDark = (By.CSS_SELECTOR, "button[aria-label='Switch to light mode']")
    toggleLight = (By.CSS_SELECTOR, "button[aria-label='Switch to dark mode']")
    linkText = (By.PARTIAL_LINK_TEXT, "Resume")

    def test_navigation_buttons(self):
        """Clicks all the Navigation Buttons and Closes"""
        elements = self.wait_for_all(self.navButtons)
        i = 1
        for e in elements:
            e.click()
            if(i != 5):
               close = self.wait_for_visible_among(self.closeButton)
               close.click()
               i+=1 
            else:
                return
            
        return self

    def toggle_to_light_mode(self):
        """Clicks the toggle to switch to light mode and verifies the switch happened."""
        toggle = self.wait_for_selector(self.toggleDark)
        toggle.click()
        self.wait_for_selector(self.toggleLight)

    def toggle_to_dark_mode(self):
        """Clicks the toggle to switch to dark mode and verifies the switch happened."""
        toggle = self.wait_for_selector(self.toggleLight)
        toggle.click()
        self.wait_for_selector(self.toggleDark)

    def open_resume(self):
        """Open the Resume in the Portfolio"""
        original_window = self.driver.current_window_handle
        original_handles = self.driver.window_handles

        resume_link = self.wait_for_link(self.linkText)
        resume_link.click()

        if not self.wait_for_new_tab(original_handles):
            raise AssertionError("Resume link did not open a new tab as expected")
       
        new_window = [h for h in self.driver.window_handles if h not in original_handles][0]
        self.driver.switch_to.window(new_window)

        self.wait_until_url_contains("resume.pdf")

    