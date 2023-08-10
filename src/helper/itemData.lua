local items = {
    apple = {
        id = "apple",
        description = "A very tasty fruit",
        max = 7,
        eat = {
            eatable = true,
            health = 1,
            power = nil
        },
        pickable = false,
        TexPath = "items/apple.png"
    },

    bread = {
        id = "bread",
        description = "bread bread bread",
        max = 5,
        eat = {
            eatable = true,
            health = 2,
            power = nil
        },
        pickable = false,
        TexPath = "items/bread.png"
    },

    rock = {
        id = "rock",
        description = "big",
        eat = {
            eatable = false,
        },
        max = 2,
        pickable = true,
        TexPath = "smallRock.png",
        converTo = "stone"
    },

    stone = {
        id = "stone",
        description = "feels hard to hold",
        max = 2,
        eat = {
            eatable = false,
        },
        pickable = true,
        TexPath = "items/rock.png"
    },

    tree = {
        pickable = false
    },

    wood = {
        id = "wood",
        description = "very dry organic durable material",
        max = 20,
        eat = {
            eatable = false,
        },
        pickable = true,
        TexPath = "items/wood.png"
    }
}

return items