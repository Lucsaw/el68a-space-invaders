library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.spaceInvadersConstants.all;

entity collisionController is
    port (
        clk, rst                        : in std_logic;
        inEnemyPositions                : in enemyPositions;
        inPlayerPositions               : in playerPositions;
        inPlayerProjectilePositions     : in playerProjectilePositions;
        inEnemyProjectilePositions      : in enemyProjectilePositions;
        outEnemyCollisions              : out std_logic_vector(N_ENEMIES-1 downto 0);
        outPlayerCollisions             : out std_logic_vector(N_PLAYERS-1 downto 0);
        outEnemyProjectileCollisions    : out std_logic_vector(N_ENEMY_PROJECTILES-1 downto 0);
        outPlayerProjectileCollisions   : out std_logic_vector(N_PLAYER_PROJECTILES-1 downto 0)
    );
end entity collisionController;

architecture aCollisionController of collisionController is
    
begin
    
    -- Enemy <--> Player Projectile
    process(clk)
    variable enemyCollisionsMask            : std_logic_vector(N_ENEMIES-1 downto 0);
    variable playerProjectileCollisionsMask : std_logic_vector(N_PLAYER_PROJECTILES-1 downto 0);
    begin
        if rising_edge(clk) then
            enemyCollisionsMask := (others => '0');
            playerProjectileCollisionsMask := (others => '0');
            for i in N_ENEMIES-1 downto 0 loop
                for j in N_PLAYER_PROJECTILES-1 downto 0 loop
                    if inEnemyPositions(i)(0) = inPlayerProjectilePositions(j)(0) and inEnemyPositions(i)(1) = inPlayerProjectilePositions(j)(1) then
                        enemyCollisionsMask(i) := '1';
                        playerProjectileCollisionsMask(j) := '1';
                    end if;
                end loop;
            end loop;
        end if;
        outEnemyCollisions <= enemyCollisionsMask;
        outPlayerProjectileCollisions <= playerProjectileCollisionsMask;
    end process;
    
    
end architecture aCollisionController;