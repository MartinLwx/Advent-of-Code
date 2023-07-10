use std::{env, fs};

#[derive(Clone, Copy)]
enum RockPaperScissors {
    Rock,
    Paper,
    Scissors,
}

impl From<&str> for RockPaperScissors {
    fn from(value: &str) -> Self {
        match value {
            "A" | "X" => Self::Rock,
            "B" | "Y" => Self::Paper,
            "C" | "Z" => Self::Scissors,
            _ => panic!("unreachable"),
        }
    }
}

impl RockPaperScissors {
    fn score(t: Self) -> i32 {
        match t {
            RockPaperScissors::Rock => 1,
            RockPaperScissors::Paper => 2,
            RockPaperScissors::Scissors => 3,
        }
    }

    fn compute_score<T, U>(you: T, me: U) -> i32
    where
        T: Into<RockPaperScissors> + Copy,
        U: Into<RockPaperScissors> + Copy,
    {
        RockPaperScissors::score(me.into())
            + match (you.into(), me.into()) {
                // lost
                (RockPaperScissors::Rock, RockPaperScissors::Scissors)
                | (RockPaperScissors::Paper, RockPaperScissors::Rock)
                | (RockPaperScissors::Scissors, RockPaperScissors::Paper) => 0,
                // draw
                (RockPaperScissors::Rock, RockPaperScissors::Rock)
                | (RockPaperScissors::Paper, RockPaperScissors::Paper)
                | (RockPaperScissors::Scissors, RockPaperScissors::Scissors) => 3,
                // win
                (RockPaperScissors::Rock, RockPaperScissors::Paper)
                | (RockPaperScissors::Paper, RockPaperScissors::Scissors)
                | (RockPaperScissors::Scissors, RockPaperScissors::Rock) => 6,
            }
    }

    /// Figure out how to make the round end as indicated
    ///
    /// `target`: "X" = lose, "Y" = draw, "Z" = win
    fn decide<T>(you: T, target: &str) -> Self
    where
        T: Into<RockPaperScissors> + Copy,
    {
        match (you.into(), target) {
            (RockPaperScissors::Rock, "X")
            | (RockPaperScissors::Scissors, "Y")
            | (RockPaperScissors::Paper, "Z") => RockPaperScissors::Scissors,
            (RockPaperScissors::Paper, "X")
            | (RockPaperScissors::Rock, "Y")
            | (RockPaperScissors::Scissors, "Z") => RockPaperScissors::Rock,
            (RockPaperScissors::Scissors, "X")
            | (RockPaperScissors::Paper, "Y")
            | (RockPaperScissors::Rock, "Z") => RockPaperScissors::Paper,
            (_, _) => panic!("unreachable"),
        }
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let content = fs::read_to_string(&args[1]).unwrap();
    let part1_score = content.lines().fold(0, |mut acc, x| {
        let strategy: Vec<&str> = x.split_whitespace().collect();
        acc += RockPaperScissors::compute_score(strategy[0], strategy[1]);
        acc
    });
    let part2_score = content.lines().fold(0, |mut acc, x| {
        let strategy: Vec<&str> = x.split_whitespace().collect();
        let me = RockPaperScissors::decide(strategy[0], strategy[1]);
        acc += RockPaperScissors::compute_score(strategy[0], me);
        acc
    });

    println!("Score: {part1_score}");
    println!("Score: {part2_score}");
}
