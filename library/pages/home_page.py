from selenium.webdriver.common.by import By
from pages.base_page import BasePage
import time

class HomePage(BasePage):
    navButtons = (By.CLASS_NAME, "nav-pill-btn")
    closeButton = (By.CLASS_NAME, "close-btn")

    def test_buttons(self):
        elements = self.wait_for_all(self.navButtons)
        i = 1
        for e in elements:
           
            time.sleep(3)
            e.click()
            time.sleep(3)
        
            
            if(i != 5):
               close = self.wait_for_visible_among(self.closeButton)
               close.click()
               time.sleep(3)
               i+=1 
            else:
                return
            
            

        return self
