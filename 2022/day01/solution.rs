use std::collections::BinaryHeap;
use std::{env, fs};

fn main() {
    let args: Vec<String> = env::args().collect();
    // use "\n\n" as the special delimiter s.t. we can get all the foods of each Elves carried
    let mut top3 = fs::read_to_string(&args[1])
        .expect("Read file failed")
        .split("\n\n")
        .fold(BinaryHeap::new(), |mut calories, block| {
            let current_sum: i32 = block.lines().map(|x| x.parse::<i32>().unwrap()).sum();
            calories.push(-current_sum);
            while calories.len() > 3 {
                calories.pop().unwrap();
            }
            calories
        });

    println!("The sum of the top3: {}", -top3.iter().sum::<i32>());
    while let Some(val) = top3.pop() {
        if top3.is_empty() {
            println!("Max calories: {}", -val);
        }
    }
}
