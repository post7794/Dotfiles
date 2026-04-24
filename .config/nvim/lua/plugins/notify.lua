return {
	"rcarriga/nvim-notify",
	lazy = true,

	config = function()
		require("notify").setup({
			background_colour = "#000000",
			fps = 60,
			render = "compact",
			stages = "fade_in_slide_out",
			timeout = 2000,
			top_down = false,
		})
	end,
}
