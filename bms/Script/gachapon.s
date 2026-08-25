module "standard.s";

//9100100	 Gachapon: Henesys 5220000, 0  => 100000100
script "gachapon1" {

	if (target.nLevel < 15 ) self.say ( "You need to be at least Level 15 in order to use Gachapon.");
	else {
		inventory = target.inventory;
		if ( inventory.itemCount( 5220000 ) >= 1 ) {
			ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket? " );
			if ( ret1 != 0 ) {
				if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
					ret2 = inventory.makeRandGachaponItem( 5220000, 0 );
					if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
					else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full." );
				}
				else self.say( "Please make room on your item inventory and then try again." );
	 		} 
			else self.say( "Please come again!" );
		}
		else self.say( "Here's Gachapon." );
	}
}

// 9100101   Gachapon: Ellinia 5220000, 1	=> 101000000
script "gachapon2" {
	if (target.nLevel < 15 ) self.say ( "You need to be at least Level 15 in order to use Gachapon.");
	else {
		inventory = target.inventory;
		if ( inventory.itemCount( 5220000 ) >= 1 ) {
			ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket?" );
			if ( ret1 != 0 ) {
				if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
					ret2 = inventory.makeRandGachaponItem( 5220000, 1 );
					if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
					else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full" );
				}
				else self.say( "Please make room on your item inventory and then try again." );
	 		} 
			else self.say( "Please come again!" );
		}
		else self.say( "Here's Gachapon." );
	}
}

// 9100102  Gachapon: Perion 5220000, 2	=> 102000000
script "gachapon3" {
	if (target.nLevel < 15 ) self.say ( "You need to be at least Level 15 in order to use Gachapon.");
	else {
	
		inventory = target.inventory;
		if ( inventory.itemCount( 5220000 ) >= 1 ) {
			ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket?" );
			if ( ret1 != 0 ) {
				if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
					ret2 = inventory.makeRandGachaponItem( 5220000, 2 );
					if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
					else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full" );
				}
				else self.say( "Please make room on your item inventory and then try again." );
	 		} 
			else self.say( "Please come again!" );
		}
		else self.say( "Here's Gachapon." );
	}
}

// 9100103	 Gachapon: Kerning City 5220000, 3	=> 103000000
script "gachapon4" {
	if (target.nLevel < 15 ) self.say ( "You need to be at least Level 15 in order to use Gachapon.");
	else {
	
		inventory = target.inventory;
		if ( inventory.itemCount( 5220000 ) >= 1 ) {
			ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket?" );
			if ( ret1 != 0 ) {
				if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
					ret2 = inventory.makeRandGachaponItem( 5220000, 3 );
					if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
					else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full" );
				}
				else self.say( "Please make room on your item inventory and then try again." );
	 		} 
			else self.say( "Please come again!" );
		}
		else self.say( "Here's Gachapon." );
	}
}

//9100104	Gachapon: Sleepywood 5220000, 4	=> 105040300
script "gachapon5" {
	if (target.nLevel < 15 ) self.say ( "You need to be at least Level 15 in order to use Gachapon.");
	else {
		
		inventory = target.inventory;
		if ( inventory.itemCount( 5220000 ) >= 1 ) {
			ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket?" );
			if ( ret1 != 0 ) {
				if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
					ret2 = inventory.makeRandGachaponItem( 5220000, 4);
					if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
					else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full" );
				}
				else self.say( "Please make room on your item inventory and then try again." );
	 		} 
			else self.say( "Please come again!" );
		}
		else self.say( "Here's Gachapon." );
	}
}

// 9100105	gachapon : Mushroom Shrine 5220000, 5	=> 800000000
script "gachapon6" {
	if (target.nLevel < 15 ) self.say ( "You need to be at least Level 15 in order to use Gachapon.");
	else {
		inventory = target.inventory;
		if ( inventory.itemCount( 5220000 ) >= 1 ) {
			ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket?" );
			if ( ret1 != 0 ) {
				if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
					ret2 = inventory.makeRandGachaponItem( 5220000, 5 );
					if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
					else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full" );
				}
				else self.say( "Please make room on your item inventory and then try again." );
	 		} 
			else self.say( "Please come again!" );
		}
		else self.say( "Here's Gachapon." );
	}
}

// 9100106	 gachapon : Showa Man 5220000, 6	=> 809000101
script "gachapon7" {
	inventory = target.inventory;
	if ( inventory.itemCount( 5220000 ) >= 1 ) {
		ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket?" );
		if ( ret1 != 0 ) {
			if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
				ret2 = inventory.makeRandGachaponItem( 5220000, 6 );
				if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
				else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full" );
			}
			else self.say( "Please make room on your item inventory and then try again." );
 		} 
		else self.say( "Please come again!" );
	}
	else self.say( "Here's Gachapon." );
}

//9100107  gachapon : Showa Woman 5220000, 7 => 809000201
script "gachapon8" {
	inventory = target.inventory;
	if ( inventory.itemCount( 5220000 ) >= 1 ) {
		ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket?" );
		if ( ret1 != 0 ) {
			if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
				ret2 = inventory.makeRandGachaponItem( 5220000, 7 );
				if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
				else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full" );
			}
			else self.say( "Please make room on your item inventory and then try again." );
 		} 
		else self.say( "Please come again!" );
	}
	else self.say( "Here's Gachapon." );
}

// 9100109  gachapon : NLC 5220000, 8	=> 600000000
script "gachapon10" {
	if (target.nLevel < 15 ) self.say ( "You need to be at least Level 15 in order to use Gachapon.");
		else {
		inventory = target.inventory;
		if ( inventory.itemCount( 5220000 ) >= 1 ) {
			ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket?" );
			if ( ret1 != 0 ) {
				if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
					ret2 = inventory.makeRandGachaponItem( 5220000, 8 );
					if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
					else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full" );
				}
				else self.say( "Please make room on your item inventory and then try again." );
	 		} 
			else self.say( "Please come again!" );
		}
		else self.say( "Here's Gachapon." );
	}
}

// 9100108  from 5220000, 9
script "gachapon9" {
	inventory = target.inventory;
	if ( inventory.itemCount( 5220000 ) >= 1 ) {
		ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket?" );
		if ( ret1 != 0 ) {
			if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
				ret2 = inventory.makeRandGachaponItem( 5220000, 9 );
				if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
				else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full" );
			}
			else self.say( "Please make room on your item inventory and then try again." );
 		} 
		else self.say( "Please come again!" );
	}
	else self.say( "Here's Gachapon." );
}

script "gachapon11" {
	inventory = target.inventory;
	if ( inventory.itemCount( 5220020 ) >= 1 ) {
		ret1 = self.askYesNo( "You may use Gachapon. Would you like to use your Gachapon ticket?" );
		if ( ret1 != 0 ) {
			if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
				ret2 = inventory.makeRandGachaponItem( 5220020, 0 );
				if ( ret2 >= 1 ) self.say( "You have obtained #b#t" + ret2 + "##k." );
				else self.say( "Please check your item inventory and see if you have the ticket, or if the inventory is full" );
			}
			else self.say( "Please make room on your item inventory and then try again." );
 		} 
		else self.say( "Please come again!" );
	}
	else self.say( "Here's Gachapon." );
}

// script "gachapon12~15

