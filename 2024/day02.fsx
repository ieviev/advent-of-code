#r "nuget: resharp.native, 0.0.16"
open System.Text
let c = Resharp.Native.RegexCompiler()
let full = System.IO.File.ReadAllText "day02.txt"

let small =
    """1 2 7 8 9
7 6 4 2 1
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"""

// The numbers are either all increasing or all decreasing.
// Numbers can occur 0 or 1 times
let nums = [ 1..9 ]
// let nums = [ 1..99 ]

let bounded x =
    x
    |> List.filter (fun v -> v > 0 && v < 100)
    |> Seq.map string
    |> String.concat "|"

let maxval = 9

// generate every single sequence of 1-9
// e.g. 1 2 3 4 5 6 7 8 9
// e.g. 1 2 3 4 5 6 7 9 8

let rec sequences acc (n: int) = [
    let nacc = n :: acc

    if n <= 1 then
        yield nacc
    else
        let plus3 =
            [ 1..3 ]
            |> List.map (fun v -> n - v)
            |> List.where (fun v -> v <= maxval && v > 0)

        stdout.WriteLine $"{n} -> %A{plus3}"

        for i in plus3 do
            yield! sequences nacc (i)
]

let seqs = [
    for n in nums do
        yield! sequences [] n
]

let patterns =
    let revs = seqs |> Seq.map List.rev

    Seq.append seqs revs
    |> Seq.where (fun s -> s.Length >= 5)
    |> Seq.map (fun s -> s |> Seq.map string |> String.concat " ")
    |> String.concat "|"

let r = c.Compile(patterns)

let lines =
    small.Split("\n") |> Seq.where (String.isNullOrWhitespace >> not) |> Seq.toArray

let valids = [
    for line in full |> String.lines do
        let m = c.IsMatch(r, line)

        if m then
            yield line
]


// 1(?=[234])
// 1(?=[234])












