local foods = {}
local snake = {}
local speed = 1
local last_dt = 0
local dir = "d"
local dir_x = 1
local dir_y = 0
local game_over = false
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

function love.load()
	snake = { { 3, 1 }, { 2, 1 }, { 1, 1 } }
	foods = { { 5, 5 }, { 8, 8 } }
end

function move_snake()
	local head = snake[1]
	local next_x = head[1] + dir_x
	local next_y = head[2] + dir_y
	for i, v in ipairs(foods) do
		if v[1] == next_x and v[2] == next_y then
			table.insert(snake, 1, v)
			table.remove(foods, i)
			return
		end
	end
	if next_x < 1 or next_x > 28 or next_y < 1 or next_y > 20 then
		game_over = true
		return
	end
	local tail = table.remove(snake)
	tail[1] = next_x
	tail[2] = next_y
	table.insert(snake, 1, tail)
end

function love.update(dt)
	if game_over then
		return
	end

	last_dt = last_dt + dt
	if speed * last_dt < 1 then return end
	last_dt = 0
	move_snake()
end

function love.draw()
    if game_over then
        love.graphics.print("Game Over",width /2 - 150,height/2-50,0,5,5)
		return
	end

	for _, v in ipairs(snake) do
		love.graphics.rectangle("line", (v[1] - 1) * 30, (v[2] - 1) * 30, 30, 30, 0, 0, 0)
	end
	for _, v in ipairs(foods) do
		love.graphics.rectangle("line", (v[1] - 1) * 30, (v[2] - 1) * 30, 30, 30, 0, 0, 0)
	end
end

function love.keypressed(key, scancode, isrepeat)
	if scancode == dir then return end
	if scancode == "d" then
		-- move right
		if dir == "a" then return end
		dir = "d"
		dir_x = 1
		dir_y = 0
	elseif scancode == "a" then
		-- move left
		if dir == "s" then return end
		dir = "a"
		dir_x = -1
		dir_y = 0
	elseif scancode == "s" then
		-- move down
		if dir == "w" then return end
		dir = "s"
		dir_x = 0
		dir_y = 1
	elseif scancode == "w" then
		-- move up
		if dir == "s" then return end
		dir = "w"
		dir_x = 0
		dir_y = -1
	elseif scancode == "escape" then
		love.event.quit()
	end
end
