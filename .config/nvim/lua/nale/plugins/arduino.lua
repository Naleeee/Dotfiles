return {
	"stevearc/vim-arduino",
	ft = "arduino",
	cmd = {
		"ArduinoAttach",
		"ArduinoChooseBoard",
		"ArduinoChooseProgrammer",
		"ArduinoChoosePort",
		"ArduinoVerify",
		"ArduinoUpload",
		"ArduinoSerial",
		"ArduinoUploadAndSerial",
		"ArduinoInfo",
	},
	init = function()
		vim.g.arduino_serial_cmd = "tio {port} -b {baud}"
	end,
	config = function()
		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>uu", "<Cmd>ArduinoUpload<CR>", { desc = "Upload sketch" })
		keymap.set("n", "<leader>uv", "<Cmd>ArduinoVerify<CR>", { desc = "Verify (compile) sketch" })
		keymap.set("n", "<leader>us", "<Cmd>ArduinoSerial<CR>", { desc = "Serial monitor (tio)" })
		keymap.set("n", "<leader>ud", "<Cmd>ArduinoUploadAndSerial<CR>", { desc = "Upload + serial monitor" })
		keymap.set("n", "<leader>ua", "<Cmd>ArduinoAttach<CR>", { desc = "Attach board" })
		keymap.set("n", "<leader>ub", "<Cmd>ArduinoChooseBoard<CR>", { desc = "Choose board" })
		keymap.set("n", "<leader>up", "<Cmd>ArduinoChoosePort<CR>", { desc = "Choose port" })
		keymap.set("n", "<leader>ui", "<Cmd>ArduinoInfo<CR>", { desc = "Arduino info" })
	end,
}
