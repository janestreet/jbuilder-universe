module Bisect_visit___expr_while___ml =
  struct
    let ___bisect_visit___ =
      let point_definitions =
        "\132\149\166\190\000\000\000/\000\000\000\011\000\000\000)\000\000\000)\b\000\000(\000\160KE\160eD\160wB\160\000PA\160\000i@\160\001\000\135C\160\001\000\169I\160\001\000\195H\160\001\000\213F\160\001\000\243G"
         in
      let point_state = Array.make 10 0  in
      Bisect.Runtime.register_file "expr_while.ml" point_state
        point_definitions;
      (fun point_index  ->
         let current_count = point_state.(point_index)  in
         point_state.(point_index) <-
           (if current_count < Pervasives.max_int
            then Pervasives.succ current_count
            else current_count))
      
  end
open Bisect_visit___expr_while___ml
let () =
  ___bisect_visit___ 5;
  print_endline "before";
  ___bisect_visit___ 4;
  while true do
    (___bisect_visit___ 2;
     print_endline "abc";
     ___bisect_visit___ 1;
     print_endline "def";
     ___bisect_visit___ 0;
     print_endline "ghi")
    done;
  ___bisect_visit___ 3;
  print_endline "after" 
let () =
  ___bisect_visit___ 9;
  print_endline "before";
  ___bisect_visit___ 8;
  while true do (___bisect_visit___ 6; print_endline "abc") done;
  ___bisect_visit___ 7;
  print_endline "after" 
