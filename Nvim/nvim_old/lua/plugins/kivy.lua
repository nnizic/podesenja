return {
	-- ✅ Syntax highlighting i indentacija za .kv
	{
		"farfanoide/vim-kivy",
		ft = "kivy",
	},

	-- ✅ LuaSnip: kompletan Kivy snippet pack za .kv fileove
	{
		"L3MON4D3/LuaSnip",
		config = function()
			local ls = require("luasnip")
			local s, t, i = ls.snippet, ls.text_node, ls.insert_node

			ls.add_snippets("kivy", {

				-- 🌈 CANVAS ELEMENTS
				s("Canvas", {
					t({ "canvas:", "\tColor:" }),
					t({ "", "\t\trgba: " }),
					i(1, "1, 0, 0, 1"),
					t({ "", "\tRectangle:" }),
					t({ "", "\t\tsize: self.size", "\t\tpos: self.pos" }),
				}),
				s("CanvasBefore", {
					t({ "canvas.before:", "\tColor:" }),
					t({ "", "\t\trgba: " }),
					i(1, "1, 1, 1, 1"),
					t({ "", "\tRectangle:" }),
					t({ "", "\t\tsize: self.size", "\t\tpos: self.pos" }),
				}),
				s("CanvasAfter", {
					t({ "canvas.after:", "\tColor:" }),
					t({ "", "\t\trgba: " }),
					i(1, "0, 0, 0, 1"),
					t({ "", "\tRectangle:" }),
					t({ "", "\t\tsize: self.size", "\t\tpos: self.pos" }),
				}),

				-- 🧱 LAYOUTS
				s("BoxLayout", {
					t({ "BoxLayout:", '\torientation: "' }),
					i(1, "vertical"),
					t({ '"' }),
					t({ "", "\tspacing: " }),
					i(2, "10"),
					t({ "", "\tpadding: " }),
					i(3, "10"),
					t({ "", "\t" }),
					i(0),
				}),
				s("GridLayout", {
					t({ "GridLayout:", "\tcols: " }),
					i(1, "2"),
					t({ "", "\tspacing: " }),
					i(2, "10"),
					t({ "", "\tpadding: " }),
					i(3, "10"),
					t({ "", "\t" }),
					i(0),
				}),
				s("FloatLayout", { t({ "FloatLayout:", "\t" }), i(0) }),
				s(
					"StackLayout",
					{ t({ "StackLayout:", '\torientation: "' }), i(1, "lr-tb"), t({ '"' }), t({ "", "\t" }), i(0) }
				),

				-- 📱 SCREENS
				s("Screen", {
					t({ "Screen:", '\tname: "' }),
					i(1, "main_screen"),
					t({ '"' }),
					t({ "", "\t" }),
					i(0),
				}),
				s("ScreenManager", {
					t({ "ScreenManager:", "\t" }),
					i(0),
				}),

				-- 🧩 BASIC WIDGETS
				s("Button", {
					t({ "Button:", "\tid: " }),
					i(1, "my_button"),
					t({ "", '\ttext: "' }),
					i(2, "Click Me"),
					t({ '"' }),
					t({ "", '\tfont_size: "' }),
					i(3, "20sp"),
					t({ '"' }),
					t({ "", "\tsize_hint: " }),
					i(4, "None, None"),
					t({ "", "\tsize: " }),
					i(5, "150, 50"),
					t({ "", '\tpos_hint: {"center_x": 0.5, "center_y": 0.5}' }),
					t({ "", "\ton_release: " }),
					i(6, "root.on_button_click()"),
				}),

				s("Label", {
					t({ "Label:", '\ttext: "' }),
					i(1, "Hello World"),
					t({ '"' }),
					t({ "", '\tfont_size: "' }),
					i(2, "32sp"),
					t({ '"' }),
					t({ "", "\tcolor: " }),
					i(3, "1, 1, 1, 1"),
					t({ "", '\tpos_hint: {"center_x": 0.5, "center_y": 0.5}' }),
				}),

				s("TextInput", {
					t({ "TextInput:", "\tid: " }),
					i(1, "input_box"),
					t({ "", '\thint_text: "' }),
					i(2, "Enter text..."),
					t({ '"' }),
					t({ "", "\tmultiline: " }),
					i(3, "False"),
					t({ "", '\tfont_size: "' }),
					i(4, "18sp"),
					t({ '"' }),
				}),

				s("Image", {
					t({ "Image:", '\tsource: "' }),
					i(1, "path/to/image.png"),
					t({ '"' }),
					t({ "", "\tsize_hint: " }),
					i(2, "None, None"),
					t({ "", "\tsize: " }),
					i(3, "200, 200"),
				}),

				s("Switch", { t({ "Switch:", "\tactive: " }), i(1, "False") }),
				s("CheckBox", { t({ "CheckBox:", "\tactive: " }), i(1, "False") }),
				s("Slider", {
					t({ "Slider:", "\tmin: " }),
					i(1, "0"),
					t({ "", "\tmax: " }),
					i(2, "100"),
					t({ "", "\tvalue: " }),
					i(3, "50"),
				}),

				-- 📜 SCROLL & RECYCLER
				s("ScrollView", { t({ "ScrollView:", "\t" }), i(0) }),
				s("RecycleView", { t({ "RecycleView:", "\t" }), i(0) }),
				s("RecycleBoxLayout", {
					t({ "RecycleBoxLayout:", "\tdefault_size: " }),
					i(1, "None, dp(56)"),
					t({ "", "\tdefault_size_hint: " }),
					i(2, "1, None"),
					t({ "", "\tsize_hint_y: None", "\theight: self.minimum_height" }),
				}),

				-- 🪟 POPUPS
				s("Popup", {
					t({ "Popup:", '\ttitle: "' }),
					i(1, "My Popup"),
					t({ '"' }),
					t({ "", "\tsize_hint: " }),
					i(2, "0.8, 0.4"),
					t({ "", "\tauto_dismiss: " }),
					i(3, "True"),
					t({ "", "\t" }),
					i(0),
				}),

				-- 🎨 COLORS & SHAPES
				s("Color", {
					t({ "Color:", "\trgba: " }),
					i(1, "1, 0, 0, 1"),
				}),
				s("Rectangle", {
					t({ "Rectangle:", "\tsize: " }),
					i(1, "self.size"),
					t({ "", "\tpos: " }),
					i(2, "self.pos"),
				}),

				-- ⚙️ EVENT TEMPLATES
				s("on_touch_down", {
					t({ "on_touch_down: " }),
					i(1, "root.on_touch_down(args)"),
				}),
				s("on_press", {
					t({ "on_press: " }),
					i(1, "root.on_press()"),
				}),
				s("on_release", {
					t({ "on_release: " }),
					i(1, "root.on_release()"),
				}),
				s("on_state", {
					t({ "on_state: " }),
					i(1, "root.on_state_change(self.state)"),
				}),

				-- 🧠 HELPERS
				s(
					"pos_hint",
					{ t({ 'pos_hint: {"center_x": ' }), i(1, "0.5"), t({ ', "center_y": ' }), i(2, "0.5"), t({ "}" }) }
				),
				s("size_hint", { t({ "size_hint: " }), i(1, "None, None") }),
			})
		end,
	},
}
