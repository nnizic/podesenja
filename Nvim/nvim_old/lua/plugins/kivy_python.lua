return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local fmt = require("luasnip.extras.fmt").fmt

    -- 🔧 Snippeti za Python strane Kivy projekte
    ls.add_snippets("python", {

      -- Kivy App skeleton
      s("kapp", fmt([[
from kivy.app import App
from kivy.uix.{} import {}

class {}App(App):
    def build(self):
        return {}()

if __name__ == "__main__":
    {}App().run()
      ]], {
        i(1, "boxlayout"), i(2, "BoxLayout"),
        i(3, "My"),
        i(4, "BoxLayout"),
        i(5, "My"),
      })),

      -- Screen Manager
      s("kscreens", fmt([[
from kivy.uix.screenmanager import ScreenManager, Screen

class {}(Screen):
    pass

class {}(Screen):
    pass

class {}(ScreenManager):
    pass
      ]], {
        i(1, "HomeScreen"),
        i(2, "SettingsScreen"),
        i(3, "MyScreenManager"),
      })),

      -- Basic widget creation
      s("kwidget", fmt([[
from kivy.uix.{} import {}

class {}({}):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        {}
      ]], {
        i(1, "button"), i(2, "Button"),
        i(3, "MyButton"), i(4, "Button"),
        i(5, "# custom logic here"),
      })),

      -- Event handler
      s("kevent", fmt([[
def on_{}(self, instance):
    {}
      ]], {
        i(1, "press"),
        i(2, 'print("Button pressed")'),
      })),

      -- App with .kv binding
      s("kappkv", fmt([[
from kivy.app import App
from kivy.lang import Builder

Builder.load_file("{}")

class {}App(App):
    pass

if __name__ == "__main__":
    {}App().run()
      ]], {
        i(1, "main.kv"),
        i(2, "My"),
        i(3, "My"),
      })),

      -- Property declaration
      s("kprop", fmt([[
from kivy.properties import {}

{} = {}({})
      ]], {
        i(1, "StringProperty"),
        i(2, "my_property"),
        i(3, "StringProperty"),
        i(4, '"default value"'),
      })),

      -- BoxLayout setup in Python
      s("kbox", fmt([[
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button

class {}(BoxLayout):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.orientation = "{}"
        self.add_widget(Button(text="{}"))
        self.add_widget(Button(text="{}"))
      ]], {
        i(1, "MyBox"),
        i(2, "vertical"),
        i(3, "OK"),
        i(4, "Cancel"),
      })),

      -- FloatLayout with custom positioning
      s("kfloat", fmt([[
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.label import Label

class {}(FloatLayout):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.add_widget(Label(text="{}", pos_hint={{"center_x": 0.5, "center_y": 0.5}}))
      ]], {
        i(1, "MyFloatLayout"),
        i(2, "Hello from Kivy!"),
      })),

      -- Popup example
      s("kpopup", fmt([[
from kivy.uix.popup import Popup
from kivy.uix.label import Label

popup = Popup(title="{}",
              content=Label(text="{}"),
              size_hint=(None, None), size=(400, 200))
popup.open()
      ]], {
        i(1, "Notification"),
        i(2, "Operation completed successfully."),
      })),

    })
  end,
}

