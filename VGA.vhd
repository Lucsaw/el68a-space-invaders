library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.spaceInvadersConstants.all;


ENTITY VGA IS
PORT(
CLOCK_50, RESET: IN STD_LOGIC;
VGA_HS,VGA_VS:OUT STD_LOGIC;
SW: STD_LOGIC_VECTOR(1 downto 0);
KEY: STD_LOGIC_VECTOR(3 DOWNTO 0);
VGA_R,VGA_B,VGA_G: OUT STD_LOGIC_VECTOR(3 downto 0);
enemies: IN enemyPositions;
enemiesRunning: IN STD_LOGIC_VECTOR(N_ENEMIES - 1 downto 0);
players: IN playerPositions;
player1Lives, player2Lives: IN integer range 0 to 3;
enemyProjectiles: IN enemyProjectilePositions;
player1Projectile: IN position;
player2Projectile: IN position
);
END VGA;


ARCHITECTURE MAIN OF VGA IS
	SIGNAL VGACLK:STD_LOGIC;
	COMPONENT SYNC IS
	PORT(
		CLK, RST: IN STD_LOGIC;
		HSYNC: OUT STD_LOGIC;
		VSYNC: OUT STD_LOGIC;
		R: OUT STD_LOGIC_VECTOR(3 downto 0);
		G: OUT STD_LOGIC_VECTOR(3 downto 0);
		B: OUT STD_LOGIC_VECTOR(3 downto 0);
		enemies: IN enemyPositions;
		enemiesRunning: IN STD_LOGIC_VECTOR(N_ENEMIES - 1 downto 0);
		players: IN playerPositions;
		player1Lives, player2Lives: IN integer range 0 to 3;
		enemyProjectiles: IN enemyProjectilePositions;
		player1Projectile: IN position;
		player2Projectile: IN position
	);
	END COMPONENT SYNC;

	COMPONENT single_pulse_debounce IS 
	PORT (
        key_in : IN std_logic;
        clk : IN std_logic;
        pulse_out : OUT std_logic;
        key_out: OUT std_logic);
	END COMPONENT single_pulse_debounce;

    COMPONENT pll is
        PORT (
            clk_out_clk : out std_logic;        -- clk
            clk_in_clk  : in  std_logic := 'X'; -- clk
            reset_reset  : in  std_logic := 'X'  -- reset
        );
	 END COMPONENT pll;
 BEGIN

 	C: pll PORT MAP (VGACLK,CLOCK_50,RESET);
 	C1: SYNC PORT MAP(VGACLK, RESET,VGA_HS,VGA_VS,VGA_R,VGA_G,VGA_B, enemies, enemiesRunning, players,player1Lives,player2Lives,enemyProjectiles,player1Projectile,player2Projectile);
 
 END MAIN;
 