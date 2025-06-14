abstract class AppStates {}

class InitialState extends AppStates {}

class SwitchToDarkState extends AppStates {}

class SwitchToLightState extends AppStates {}

class SwitchToFollowSystemState extends AppStates {}

class ReRenderState extends AppStates {}

class ItemAddedToCart extends AppStates {}

class ItemRemovedFromCartCart extends AppStates {}

class CartIcremented extends AppStates {}

class ItemAddedToWishList extends AppStates {}

class ItemRemovedFromWishList extends AppStates {}

class WishListIcremented extends AppStates {}
