import cohere
from cohere.classify import Example
from sklearn.model_selection import train_test_split
from typing import List
import pandas
import os

os.chdir(r"AI/google_dataset")
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
    df["isTherePositive"] = False
    for tag in tags_pos:
        df["isTherePositive"] = df["isTherePositive"] | df[tag]

    for tag in tags_neg:
        df["isTherePositive"] = df["isTherePositive"] & ~df[tag]

    examples = []

    for i, row in df.sample(n=2500).iterrows():
        examples.append(Example(row[1], str(int(row[-1]))))

    return examples


examples = makeExamples(df, positive, negative)


def isAtricleGoodFromComments(comments: List[str]) -> bool:
    # temporary
    input = [",".join(comments)]
    print(type(input))
    return bool(
        int(
            co.classify(
                examples=examples, inputs=input, model="small"
            )
            .classifications[0]
            .prediction
        )
    )


print(examples[:5])
print(isAtricleGoodFromComments(["I love thi post"]))
