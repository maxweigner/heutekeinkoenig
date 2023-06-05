import random
from pyswip import Prolog as pl
import itertools as it

print("Consulting")
pl.consult("main.pl")

HPog = [1,2,3,5]
APog = [2,3,4,5]

HPmult = 2
APmult = 2

print("AP:HP:HPnew\n")

for i in range(0,4):
	HP = HPog
	AP = HPog
	match i:
		case 0:
			print("## Calculating without Multipliers ##")

		case 1:
			print("\n## Calculating with Attack Multipliers ##")
			AP = [point * 2 for point in AP]

		case 2:
			print("\n## Calculating with Defense Multipliers ##")
			HP = [point * 2 for point in HP]
			

		case 3:
			print("\n## Calculating with Attack and Defense Multipliers ##")
			AP = [point * 2 for point in AP]
			HP = [point * 2 for point in HP]


	print("-First Iteration-")

	liste = [AP, HP]
	combinations = [p for p in it.product(*liste)]

	newcombs = []

	for comb in combinations:
		for soln in pl.query("einheit_alive("+str(comb[0])+","+str(comb[1])+", HPnew)"):
			print(str(comb[0]) + ":" + str(comb[1]) + ":" + str(soln["HPnew"]))
			newcombs.append((comb[0], soln["HPnew"]))

	print("-Second Iteration-")
	
	for comb in newcombs:
		for soln in pl.query("einheit_alive("+str(comb[0])+","+str(comb[1])+", HPnew)"):
			print(str(comb[0]) + ":" + str(comb[1]) + ":" + str(soln["HPnew"]))
