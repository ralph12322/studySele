from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
import time
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Chrome()

driver.get("https://deralph.vercel.app/")

WebDriverWait(driver, 5).until(
    EC.presence_of_element_located((By.CLASS_NAME, "sb-bubble-btn"))
)
element = driver.find_element(By.CLASS_NAME, "sb-bubble-btn")
element.click() 
time.sleep(10)

driver.quit();
