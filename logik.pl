% hier kommt der ganze logik bums hin

% globalen Turncounter

player_turn(Player) :-

    % calculate action points
    calc_action_points(Player, Turncounter)


    % further logic



    % end of turn
    % save remaining ap
    save_action_points(Player)