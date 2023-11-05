local Transition = require(script.Parent.Transition)

--[=[
    @class State

    Describes one of the many states an object can have. It also declares
    how it should behave when it enters, is and leaves the given state
]=]
local State = {}
State.__index = State
State.Name = "" :: string
State.Transitions = {} :: {Transition.Transition}
State.Data = {} :: {[string]: any}
State._changeState = nil :: (newState: string)->()?

--[=[
    Used to create a new State. The state should manage how the object should behave during
    that given state. I personally recommend having your states in their own files for organizational
    purposes

    ```lua
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local StateMachine = require(ReplicatedStorage.RobloxStateMachine)
    local State = StateMachine.State

    local Default = State.new("Blue") -- The name of this state is "Blue"
    Default.Transitions = { -- The transitions that will be listened to while in the blue state
        transition1,
        transition2
    }
    function Default:OnEnter(data)
        data.part.Color = Color3.fromRGB(0, 166, 255) --This will turn the part Blue when it enters the state blue
    end

    return Default
    ```

    @param stateName string?

    @return State
]=]
function State.new(stateName: string?): State
    local self = setmetatable({}, State)
    
    self.Name = stateName or ""
    self.Transitions = {}

    return self
end

--[=[
    Forcelly changes the current state of our state machine to a new one

    @param newState string -- The name of the new state

    @return ()
]=]
function State:ChangeState(newState: string): ()
    if not self._changeState then
        return
    end

    self._changeState(newState)
end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    Called whenever a state machine is created with this state.

    ```lua
    function State:OnInit(data)
        print("I was init!")
        self.SomeStartingData = tick()
    end
    ```

    @param data {[string]: any} -- This is the data from the StateMachine itself!

    @return ()
]=]
function State:OnInit(data: {[string]: any}): ()
    assert(data)
end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    Called whenever you enter this state

    ```lua
    function State:OnEnter(data)
        data.part.Color = Color3.fromRGB(0, 166, 255)
    end
    ```

    @param data {[string]: any} -- This is the data from the StateMachine itself!

    @return ()
]=]
function State:OnEnter(data: {[string]: any}): ()
    assert(data)
end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    Called every frame after the physics simulation while in this state

    ```lua
    function Default:OnHeartbeat(data, deltaTime: number)
        self.timePassed += deltaTime
    end
    ```

    @param data {[string]: any} -- This is the data from the StateMachine itself!
    @param deltaTime number

    @return ()
]=]
function State:OnHeartbeat(data: {[string]: any}, deltaTime: number): ()
    assert(data and deltaTime)
end

--[=[
    :::info
    This is a **Virtual Method**. Virtual Methods are meant to be overwritten
    :::

    Called whenever you leave this state

    ```lua
    function State:OnLeave(data)
        data.stuff:Clean()
    end
    ```

    @param data {[string]: any} -- This is the data from the StateMachine itself!

    @return ()
]=]
function State:OnLeave(data: {[string]: any}): ()
    assert(data)
end

export type State = typeof(State)

return State