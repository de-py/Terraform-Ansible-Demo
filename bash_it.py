import sys




def main():
    name = input("Output filename: ")
    with open(sys.argv[1], "r") as f:
        lines = f.readlines()
        for line in lines:
            line = line.strip()
            print("echo '%s' >> %s" % (line, name))





if __name__ == "__main__":
    main()