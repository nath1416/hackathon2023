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


def makeExamples(df, tags_pos, tags_neg):
    df = df.sample(n=2500)

    df["isTherePositive"] = False
    df["label"] = 0
    last_pos = pandas.Series([True for i in range(len(df))])
    for tag in tags_pos:
        df["isTherePositive"] = df["isTherePositive"] | df[tag]
        for i, square in enumerate(df["isTherePositive"]):
            if (square == True) and (df.iloc[i, -1] == 0):
                df.iloc[i, -1] = tag

    for tag in tags_neg:
        df["isTherePositive"] = df["isTherePositive"] & ~df[tag]

    examples = []

    for i, row in df.iterrows():
        examples.append(Example(row[1], str(row[-1])))

    print(df)
    return examples


examples = makeExamples(df, positive, negative)


def isAtricleGoodFromComments(comments: List[str]) -> bool:
    # temporary
    input = [",".join(comments)]
    print(type(input))

    pred = co.classify(
        examples=examples,
        inputs=input,
        model="large",
    ).classifications[0]
    return pred.prediction, pred.confidence


print(examples[5])
print(
    isAtricleGoodFromComments(["hello, i absolutely love and adore this post wow!!!"])
)
