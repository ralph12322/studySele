from pages.base_page import BasePage
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys


class SignPage(BasePage):
    name = (By.NAME, "name")
    email = (By.NAME, "email")
    password = (By.NAME, "password")
    confirm_password = (By.NAME, "confirmPassword")
    success_url = "https://teampayaman.vercel.app/"
    error_message = (By.CSS_SELECTOR, "p[role='alert']")
    sign_up_tab = (By.XPATH, "//button[@type='button'][normalize-space()='Sign Up']")
    




    #Log in section:

    def _submit_credentials_for_signin(self, user_email, user_password):
        """Fill in the form and press Enter."""
        email_field = self.wait_for_clickable(self.email)
        email_field.clear()
        email_field.send_keys(user_email)

        password_field = self.wait_for_clickable(self.password)
        password_field.clear()
        password_field.send_keys(user_password)
        password_field.send_keys(Keys.ENTER)

    def valid_login(self, user_email, user_password):
        """Log in with valid credentials and wait for the redirect."""
        self._submit_credentials_for_signin(user_email, user_password)
        self.wait_until_url(self.success_url)

    def invalid_login(self, user_email, user_password):
        """Log in with bad credentials and return the error message text."""
        self._submit_credentials_for_signin(user_email, user_password)
        return self.wait_for_visible(self.error_message).text


    #Signup section:

    def _submit_credentials_for_signup(self, user_email, user_password, user_name):
            """Fill in the form and press Enter."""

            signup_button = self.wait_for_clickable(self.sign_up_tab)
            signup_button.click()
            self.wait_for_visible(self.name)

            name_field = self.wait_for_clickable(self.name)
            name_field.clear()
            name_field.send_keys(user_name)

            email_field = self.wait_for_clickable(self.email)
            email_field.clear()
            email_field.send_keys(user_email)
    
            password_field = self.wait_for_clickable(self.password)
            password_field.clear()
            password_field.send_keys(user_password)

            password_field = self.wait_for_clickable(self.confirm_password)
            password_field.clear()
            password_field.send_keys(self.confirm_password)
            password_field.send_keys(Keys.ENTER)

    def valid_signup(self, user_name, user_email, user_password):
        """Signs up with valid credentials"""
        self._submit_credentials_for_signup(user_name, user_email, user_password)
        self.wait_until_url(self.success_url)

    def invalid_signup(self, user_name, user_email, user_password):
         """Signs up with invalid credentials"""
         self._submit_credentials_for_signup(user_name, user_email, user_password)
         return self.wait_for_visible(self.error_message).text