import cohere
from cohere.classify import Example
from sklearn.model_selection import train_test_split
from typing import List
import pandas
import os

co = cohere.Client("FU0PxYd1At7VfBuFkqAX5I1G4Poykr7dmgoM8fsg")
df = pandas.read_csv("go_emotions_dataset.csv")

positive = [
    "admiration",
    "amusement",
    "approval",
    "caring",
    "love",
    "optimism",
    "relief",
]

negative = ["disapproval", "disgust", "embarrassment", "sadness", "anger"]
cancel_words = ["drown", "kill"]


def makeExamples(df, tags_pos, tags_neg):
    df = df.sample(n=2500)

    df["isTherePositive"] = False
    df["label"] = "0"
    for tag in tags_pos:
        df["isTherePositive"] = df["isTherePositive"] | df[tag]
        for i, square in enumerate(df["isTherePositive"]):
            if (square == True) and (df.iloc[i, -1] == "0"):
                df.iloc[i, -1] = tag

    for tag in tags_neg:
        df["isTherePositive"] = df["isTherePositive"] & ~df[tag]

    examples = []
    mot_inderdit = False
    for i, row in df.iterrows():
        for cancel in cancel_words:
            if cancel in row[1]:
                mot_inderdit = True

        if mot_inderdit:
            examples.append(Example(row[1], "0"))
            mot_inderdit = False

        elif row[-2]:
            examples.append(Example(row[1], str(row[-1])))

        else:
            examples.append(Example(row[1], "0"))

    return examples


examples = makeExamples(df, positive, negative)


def isAtricleGoodFromComments(comments: List[str]) -> bool:
    # temporary
    input = [",".join(comments)]
    banned_words = ["drown", "kill", "rape", "murder", "crime"]
    for banned_word in banned_words:
        if banned_word in input[0]:
            print(f"mot inderdit {banned_word}")
            return "0", 0
    pred = co.classify(
        examples=examples,
        inputs=input,
        model="large",
    ).classifications[0]
    return "" if pred.prediction == "0" else pred.prediction, pred.confidence


print(
    isAtricleGoodFromComments(
        ["hello, i absolutely love and adore this post wow killer!!!"]
    )
)
